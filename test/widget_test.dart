import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:demo/main.dart';

void main() {
  testWidgets('store screen renders Oventine store information and menu', (
    WidgetTester tester,
  ) async {
    _setTestViewport(tester);
    await tester.pumpWidget(const KuickoApp());
    await tester.pumpAndSettle();

    // Verify Store Title and Ratings
    expect(find.text('Oventine - By Al Safadi'), findsOneWidget);
    expect(find.text('Top rated in Arabic'), findsOneWidget);
    expect(find.text('Exceptional'), findsOneWidget);
    expect(find.text('20-35 mins'), findsOneWidget);

    // Verify "Picks for you 🔥" Section
    expect(find.text('Picks for you 🔥'), findsNWidgets(2)); // in tab and section
    expect(find.text('Akkawi'), findsOneWidget);
    expect(find.text('د.إ 18.00'), findsAtLeastNWidgets(1));

    // Tap on Akkawi to open customization sheet or add
    await tester.tap(find.text('Akkawi'));
    await tester.pumpAndSettle();

    // Customization sheet should be open
    expect(find.text('Add to Basket'), findsOneWidget);
    await tester.tap(find.text('Add to Basket'));
    await tester.pumpAndSettle();

    // Basket bottom bar should appear
    expect(find.text('View basket'), findsOneWidget);
  });

  testWidgets('menu category switches and displays Macro Madness', (
    WidgetTester tester,
  ) async {
    _setTestViewport(tester);
    await tester.pumpWidget(const KuickoApp());
    await tester.pumpAndSettle();

    // Tap on Macro Madness category
    await tester.tap(find.text('Macro Madness').first);
    await tester.pumpAndSettle();

    expect(find.text('Chicken58'), findsOneWidget);
    expect(find.text('P:47g, C:38g , F:19g , Cal:520.'), findsOneWidget);
  });

  testWidgets('hero search opens and filters items', (
    WidgetTester tester,
  ) async {
    _setTestViewport(tester);
    await tester.pumpWidget(const KuickoApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Search menu'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Philly');
    await tester.pumpAndSettle();

    expect(find.text('Philly Cheesesteak'), findsOneWidget);
  });
}

void _setTestViewport(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(400, 900)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}
