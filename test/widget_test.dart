// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:form_screen/main.dart';

void main() {
  testWidgets('Registration form smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the registration form is displayed.
    expect(find.text('Registration Form'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Verify Submit and Clear buttons exist.
    expect(find.text('Submit'), findsOneWidget);
    expect(find.text('Clear'), findsOneWidget);
  });
}
