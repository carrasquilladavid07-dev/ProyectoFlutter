

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