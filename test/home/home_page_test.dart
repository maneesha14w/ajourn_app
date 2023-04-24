import 'package:ajourn_app/pages/home/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ajourn_app/components/home/entry_card.dart';

void main() {
  group('HomePage', () {
    testWidgets('Renders the app bar title', (WidgetTester tester) async {
      await tester.pumpWidget(const HomePage());

      final titleFinder = find.text('Ajourn');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Renders the "Create Entry" button',
        (WidgetTester tester) async {
      await tester.pumpWidget(const HomePage());

      final buttonFinder =
          find.widgetWithText(FloatingActionButton, 'Create Entry');
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('Renders the recent journal entries',
        (WidgetTester tester) async {
      await tester.pumpWidget(const HomePage());

      final entriesFinder = find.byWidget(entryCard(() {}, '', '', ''));
      expect(entriesFinder, findsWidgets);
    });
  });
}
