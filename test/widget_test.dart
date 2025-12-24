import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_yama_app/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const SuperYamaApp());
    expect(find.text('Super Yama'), findsWidgets);
  });
}
