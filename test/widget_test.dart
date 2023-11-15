import 'package:calculator/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Runs widget tests for the Calculator app.
///
/// Creates a MaterialApp with the HomeView, then finds and interacts with widgets:
/// - Finds the Answer, Number1, and Number2 widgets
/// - Finds the add, subtract, multiply, divide icons
/// - Enters numbers into the Number1 and Number2 fields
/// - Taps the add icon to trigger a calculation
/// - Verifies the calculation result is displayed
void main() {
  group("Calculator View Test", () {
    testWidgets("Calculator Basic Test", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeView()));

      expect(find.byKey(const Key("Answer")), findsOneWidget);
      expect(find.byKey(const Key("Number1")), findsOneWidget);
      expect(find.byKey(const Key("Number2")), findsOneWidget);

      expect(find.byIcon(CupertinoIcons.add), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.minus), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.multiply), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.divide), findsOneWidget);
    });
    testWidgets("Calculator Addition Test", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeView()));

      await tester.enterText(find.byKey(const Key("Number1")), "20");
      await tester.enterText(find.byKey(const Key("Number2")), "10");

      await tester.tap(find.byIcon(CupertinoIcons.add));

      await tester.pump();

      expect(find.text("30"), findsOneWidget);
    });

    testWidgets("Calculator Subtract Test", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeView()));

      await tester.enterText(find.byKey(const Key("Number1")), "20");
      await tester.enterText(find.byKey(const Key("Number2")), "5");

      await tester.tap(find.byIcon(CupertinoIcons.minus));

      await tester.pump();

      expect(find.text("15"), findsOneWidget);
    });
  });
}
