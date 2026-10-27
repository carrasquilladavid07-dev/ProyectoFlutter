class Criterio {
  Criterio({
    required this.codigo,
    required this.descripcion,
    this.cumple = false,
  });

  final String codigo;
  final String descripcion;
  bool cumple;

  Criterio copiar() {
    return Criterio(
      codigo: codigo,
      descripcion: descripcion,
      cumple: cumple,
    );
  }
}