import 'package:daily_learning_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('adds a learning session', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const DailyLearningTrackerApp());
    await tester.pumpAndSettle();

    expect(find.text('Daily Learning Tracker'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Algorithms');
    await tester.enterText(find.byType(TextFormField).at(1), '25');
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'Solved recursion drills.',
    );
    await tester.drag(find.byType(ListView), const Offset(0, -350));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text('Algorithms'), findsOneWidget);
    expect(find.text('Solved recursion drills.'), findsOneWidget);
  });
}
