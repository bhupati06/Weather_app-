// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_appp/main.dart';

void main() {
  testWidgets('Basic app test', (WidgetTester tester) async {
    // Build test app
    // await tester.pumpWidget(const MyApp());

    // Check for expected text
    expect(find.text('Weather App Test'), findsOneWidget);
  });
}
