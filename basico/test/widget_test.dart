// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:basico/main.dart';

void main() {
  testWidgets('Marcar un modelo aumenta el total', (tester) async {
    // 1. Preparar: dibujar la app en un entorno de prueba
    await tester.pumpWidget(const VerificacionApp());
    expect(find.text('Modelos verificados: 0 de 4'),
findsOneWidget);
    
    // 2. Actuar: marcar el primer modelo y redibujar
    await tester.tap(find.text('Modelo de casos de uso'));
    await tester.pump() ;
    
    // 3. Verificar: el total debe estar en 1
    expect(find.text('Modelos verificados: 1 de 4'),
findsOneWidget);
    expect(find.text('Modelos verificados: 0 de 4'),
findsNothing);
  });
}

