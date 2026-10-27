import 'package:flutter/material.dart';

import '../datos/repositorio_verificaciones.dart';
import '../modelos/verificacion.dart';
import 'estilo_estado.dart';
import 'pantalla_formulario.dart';
import 'pantalla_reporte.dart';

/// Pantalla principal: lista las verificaciones del arreglo.
class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key, required this.repositorio});

  final RepositorioVerificaciones repositorio;

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  /// Mejora propia: estado por el que se filtra la lista (null = todos).
  EstadoVerificacion? _filtro;

  Future<void> _abrirFormulario() async {
    // Espera el resultado que devuelve Navigator.pop del formulario.
    final nueva = await Navigator.push<Verificacion>(
      context,
      MaterialPageRoute(builder: (_) => const PantallaFormulario()),
    );
    if (nueva == null || !mounted) return;

    setState(() => widget.repositorio.agregar(nueva));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Se guardó: ${nueva.modelo}')),
    );
  }

  void _abrirReporte() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaReporte(repositorio: widget.repositorio),
      ),
    );
  }

  Future<void> _confirmarEliminar(int indice) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (contexto) => AlertDialog(
        title: const Text('Eliminar verificación'),
        content: const Text('¿Desea eliminar este registro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(contexto, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(contexto, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmar == true) {
      setState(() => widget.repositorio.eliminar(indice));
    }
  }

  /// Chips para filtrar la lista por estado.
  Widget _barraFiltros() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('Todos'),
            selected: _filtro == null,
            onSelected: (_) => setState(() => _filtro = null),
          ),
          for (final e in EstadoVerificacion.values) ...[
            const SizedBox(width: 8),
            ChoiceChip(
              avatar: Icon(iconoEstado(e), color: colorEstado(e), size: 18),
              label: Text(
                '${e.texto} (${widget.repositorio.contarPorEstado(e)})',
              ),
              selected: _filtro == e,
              onSelected: (_) => setState(() => _filtro = e),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todas = widget.repositorio.todas;
    // Lista que se muestra según el filtro elegido.
    final visibles = _filtro == null
        ? todas
        : todas.where((v) => v.estado == _filtro).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Verificación de modelos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Verificaciones registradas: ${todas.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ElevatedButton.icon(
                  // Con null el botón queda deshabilitado.
                  onPressed: todas.isEmpty ? null : _abrirReporte,
                  icon: const Icon(Icons.assessment),
                  label: const Text('Generar reporte'),
                ),
              ],
            ),
          ),
          _barraFiltros(),
          const SizedBox(height: 8),
          Expanded(
            child: visibles.isEmpty
                ? Center(
                    child: Text(
                      todas.isEmpty
                          ? 'Aún no hay verificaciones.'
                          : 'No hay verificaciones con ese estado.',
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 88),
                    itemCount: visibles.length,
                    itemBuilder: (context, i) {
                      final v = visibles[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: Icon(
                            iconoEstado(v.estado),
                            color: colorEstado(v.estado),
                          ),
                          title: Text(v.modelo),
                          subtitle: Text(
                            '${v.porcentaje.toStringAsFixed(0)} % · '
                            '${v.estado.texto}\n'
                            'Verificó: ${v.verificador}',
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            tooltip: 'Eliminar',
                            icon: const Icon(Icons.delete_outline),
                            // Con el filtro activo, el índice de la lista
                            // visible no es el del arreglo: se busca el real.
                            onPressed: () =>
                                _confirmarEliminar(todas.indexOf(v)),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirFormulario,
        icon: const Icon(Icons.add),
        label: const Text('Nueva verificación'),
      ),
    );
  }
}