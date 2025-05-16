import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/main.dart';

void main() {
  testWidgets('WeatherApp displays city and temperature', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the default city (Toshkent) and temperature are displayed.
    expect(find.text('Toshkent'), findsOneWidget);
    expect(find.text('28°C'), findsOneWidget);

    // Tap the dropdown to select Samarqand.
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Samarqand').last);
    await tester.pumpAndSettle();

    // Verify that Samarqand and its temperature are displayed.
    expect(find.text('Samarqand'), findsOneWidget);
    expect(find.text('25°C'), findsOneWidget);
  });
}