import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:arunalu_technics/starting_screens/main.dart';  // Correct import

void main() {
  testWidgets('Login Screen Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // await tester.pumpWidget(const ArunaluAdminApp());  // Use ArunaluAdminApp instead of MyApp

    // Verify that the login screen is loaded.
    expect(find.text('Arunalu Admin Login'), findsOneWidget);  // Check if the title exists

    // Verify that the login button is present
    expect(find.byType(ElevatedButton), findsOneWidget);  // Check if the ElevatedButton exists
  });
}
