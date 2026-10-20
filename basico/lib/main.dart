import 'package:flutter/material.dart';

void main() {
  runApp(const VerificacionApp());
}

class VerificacionApp extends StatelessWidget {
  const VerificacionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verificación de modelos',
      theme: ThemeData(colorSchemeSeed:  const Color.fromARGB(255, 255, 47, 0)),
      home: const PaginaInicio(),
    );
  }
}

class PaginaInicio extends StatefulWidget {
  const PaginaInicio({super.key});

  @override
  State<PaginaInicio> createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  final List<String> _modelos = [
    'Modelo de casos de uso',
    'Modelo de actividades',
    'Modelo de secuencia',
    'Modelo de clases',
    'Modelo de despliegue',
    'Modelo de componentes'
  ];
  final List<bool> _verificado = List.filled(6, false);

  int get _totalVerificados =>
      _verificado.where((v) => v).length;

  @override
  Widget build(BuildContext context) {
    final total = _modelos.length;
    final resumen =
        'Modelos verificados: $_totalVerificados de $total';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificación de modelos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              resumen,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          for (int i = 0; i < _modelos.length; i++)
            CheckboxListTile(
              title: Text(_modelos[i]),
              value: _verificado[i],
              onChanged: (valor) {
                setState(() {
                  _verificado[i] = valor ?? false;
                });
              },
            )
        ],
      ),
    );
  }
}