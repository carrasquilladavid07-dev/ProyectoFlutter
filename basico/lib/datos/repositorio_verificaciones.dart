import '../modelos/verificacion.dart';

class RepositorioVerificaciones {
  final List<Verificacion> _verificaciones = [];

  List<Verificacion> get todas => List.unmodifiable(_verificaciones);

  int get total => _verificaciones.length;

  bool get estaVacio => _verificaciones.isEmpty;

  void agregar(Verificacion verificacion) {
    _verificaciones.add(verificacion);
  }

  void eliminar(int indice) {
    _verificaciones.removeAt(indice);
  }

  int contarPorEstado(EstadoVerificacion estado) {
    return _verificaciones.where((v) => v.estado == estado).length;
  }

  double get promedioGeneral {
    if (_verificaciones.isEmpty) return 0;
    final suma = _verificaciones.fold<double>(
        0,
        (acumulador, v) => acumulador + v.porcentaje);
    return suma / _verificaciones.length;
  }


  String get estadoGeneral {
    if (_verificaciones.isEmpty) return 'Sin verificaciones';
    final promedio = promedioGeneral;
    if (contarPorEstado(EstadoVerificacion.rechazado) > 0) {
      return 'Requiere correciones';
    }
    if (contarPorEstado(EstadoVerificacion.conObservaciones) > 0) {
      return 'Aprobado con observaciones';
    }
    return 'Aprobado';
  }
}