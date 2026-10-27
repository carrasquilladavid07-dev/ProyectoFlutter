import 'criterio.dart';

class ModeloAnalisis {
  ModeloAnalisis({required this.nombre, required this.criterios});

  final String nombre;
  final List<Criterio> criterios;

  int get criteriosCumplidos => criterios.where((c) => c.cumple).length;
}