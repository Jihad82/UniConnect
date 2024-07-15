// Import required packages and files
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uniconnect/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Mock SharedPreferences instance

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our initial text '0' is found.
    expect(find.text('0'), findsOneWidget);
    // Verify that text '1' is not found initially.
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that text '0' is no longer found after tapping.
    expect(find.text('0'), findsNothing);
    // Verify that text '1' appears after tapping.
    expect(find.text('1'), findsOneWidget);
  });
}
