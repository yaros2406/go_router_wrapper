import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../examples/screens.dart';

void main() {
  testWidgets('ProfileScreen shows appropriate message based on authentication status', (WidgetTester tester) async {
    final isAuthenticated = false;
    await tester.pumpWidget(MaterialApp(
      home: ProfileScreen(isAuthenticated: isAuthenticated),
    ));

    expect(find.text('You are not authorized to view this page.'), findsOneWidget);
    expect(find.text('Welcome to your profile!'), findsNothing);
  });
}

