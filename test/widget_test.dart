// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_project/main.dart';

void main() {
  testWidgets('BottomNavigationBar navigation test', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    // Note: WebView initialization might fail in test environment without platform mocks.
    // Proceeding with basic structure test if possible.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that our home text is present.
    // "Home Item 0" is the new body text format.
    expect(find.text('Home Item 0'), findsOneWidget);

    // Verify that the header list items for HOME are present.
    expect(find.text('ホーム'), findsOneWidget); // Header item
    expect(find.text('新着情報'), findsOneWidget); // Header item
    expect(find.text('お知らせ'), findsOneWidget); // Header item

    // Verify initial selection (Implicitly checking logic, visual test requires Golden test)
    // Tap '新着情報'
    await tester.tap(find.text('新着情報'));
    await tester.pump();
    // Since this is stateful widget internal state, we can't easily assert "selected" state
    // without reading widget properties or finding the Underline container.
    // For now, ensuring it doesn't crash is good.

    expect(find.text('Shopping Item 0'), findsNothing);

    // Tap the '買い物' (Shopping) icon and trigger a frame.
    await tester.tap(find.text('買い物'));
    await tester.pump();

    // Verify that the content has changed to Shopping.
    expect(find.text('Home Item 0'), findsNothing);
    expect(find.text('Shopping Item 0'), findsOneWidget);

    // Verify Shopping header items
    expect(find.text('クラフト感あふれるアイテム'), findsOneWidget);
  });
}
