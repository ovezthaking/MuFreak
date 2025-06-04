// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mufreak/main.dart';
import 'package:mufreak/views/screens/ai_screen.dart';
import 'package:mufreak/views/screens/search_screen.dart';
import 'package:mufreak/views/screens/auth/login_screen.dart';

void main() {
  testWidgets('App loads and shows LoignScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('MuFreak'), findsOneWidget);
  });

  testWidgets('BottomNavigationBar switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Zakładamy, że HomeScreen jest domyślny
    expect(find.byIcon(Icons.home), findsOneWidget);

    // Przełącz na AI
    await tester.tap(find.byIcon(Icons.info));
    await tester.pumpAndSettle();
    expect(find.byType(AiScreen), findsOneWidget);
  });

  testWidgets('Search icon opens SearchScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Kliknij lupę
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(find.byType(SearchScreen), findsOneWidget);
  });

  testWidgets('AI screen input and send button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AiScreen()));
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Send'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Who wrote Imagine?');
    await tester.tap(find.text('Send'));
    await tester.pump();
    // Odpowiedź AI pojawi się asynchronicznie, więc nie sprawdzamy jej treści
  });
}