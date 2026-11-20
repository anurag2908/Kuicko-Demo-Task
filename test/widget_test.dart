import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:demo/main.dart';

void main() {
  testWidgets('store menu can add and remove an item', (
    WidgetTester tester,
  ) async {
    _setTestViewport(tester);
    await tester.pumpWidget(const KuickoApp());
    await tester.pumpAndSettle();

    expect(find.text("Luca's Kitchen"), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Classic Smash'),
      450,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Classic Smash'), findsOneWidget);

    await tester.ensureVisible(find.text('ADD').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('ADD').first);
    await tester.pumpAndSettle();
    expect(find.text('View basket'), findsOneWidget);
    expect(find.text('AED 42'), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.remove).first);
    await tester.pumpAndSettle();
    expect(find.text('View basket'), findsNothing);
  });

  testWidgets('menu category changes the visible menu items', (
    WidgetTester tester,
  ) async {
    _setTestViewport(tester);
    await tester.pumpWidget(const KuickoApp());
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Bowls'),
      450,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Bowls'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Green Goddess Bowl'),
      450,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Green Goddess Bowl'), findsOneWidget);
    expect(find.text('Classic Smash'), findsNothing);
  });

  testWidgets('hero search opens and filters the menu', (
    WidgetTester tester,
  ) async {
    _setTestViewport(tester);
    await tester.pumpWidget(const KuickoApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Search menu'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'truffle');
    await tester.pumpAndSettle();

    expect(find.text('Truffle Mushroom'), findsOneWidget);
    expect(find.text('Classic Smash'), findsNothing);
  });
}

void _setTestViewport(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(400, 900)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}
