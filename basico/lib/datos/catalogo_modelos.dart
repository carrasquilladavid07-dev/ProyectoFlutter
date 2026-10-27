import '../modelos/criterio.dart';
import '../modelos/modelo_analisis.dart';

ModeloAnalisis _crearModelo(
  String nombre,
  Map<String, String> criterios,
) {
  return ModeloAnalisis(
    nombre: nombre,
    criterios: criterios.entries
        .map((e) => Criterio(codigo: e.key, descripcion: e.value))
        .toList(),
  );
}

List<ModeloAnalisis> crearCatalogo() {
  return [
    _crearModelo('Modelo de casos de uso', {
      'CU-01': 'Los actores estan identificados y nombrados',
      'CU-02': 'Los casos de uso estan identificados y nombrados',
      'CU-03': 'Los casos de uso tienen una descripcion clara y concisa',
      'CU-04': 'Los casos de uso tienen un flujo principal y alternativo',
      'CU-05': 'Los casos de uso tienen precondiciones y postcondiciones'
    }),
    _crearModelo('Modelo de clases', {
      'CL-01': 'Las actividades estan identificadas y nombradas',
      'CL-02': 'Las actividades tienen un flujo principal y alternativo',
      'CL-03': 'Las actividades tienen precondiciones y postcondiciones',
      'CL-04': 'Las actividades tienen un diagrama de flujo claro y conciso'
    }),
    _crearModelo('Modelo de secuencia', {
      'SE-01': 'Los objetos estan identificados y nombrados',
      'SE-02': 'Los mensajes estan identificados y nombrados',
      'SE-03': 'Los mensajes tienen un flujo principal y alternativo',
      'SE-04': 'Los mensajes tienen precondiciones y postcondiciones',
      'SE-05': 'Los mensajes tienen un diagrama de secuencia claro y conciso'
    }),
    _crearModelo('Modelo de actividades', {
      'AC-01': 'Los objetos estan identificados y nombrados',
      'AC-02': 'Los mensajes estan identificados y nombrados',
      'AC-03': 'Los mensajes tienen un flujo principal y alternativo',
      'AC-04': 'Los mensajes tienen precondiciones y postcondiciones',
      'AC-05': 'Los mensajes tienen un diagrama de secuencia claro y conciso',
    }),
  ];
}