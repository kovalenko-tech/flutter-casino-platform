import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_casino_platform/shared/widgets/app_button.dart';

void main() {
  group('AppButton.primary', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(label: 'Tap me', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Tap me'), findsOneWidget);
    });

    testWidgets('shows CircularProgressIndicator when isLoading=true',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(
              label: 'Tap me',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('hides label when isLoading=true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(
              label: 'Tap me',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Tap me'), findsNothing);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(
              label: 'Go',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onPressed when isLoading=true', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(
              label: 'Go',
              isLoading: true,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);
      expect(tapped, isFalse);
    });

    testWidgets('renders as ElevatedButton', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(label: 'Primary', onPressed: () {}),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('AppButton.secondary', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.secondary(label: 'Cancel', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('renders as OutlinedButton', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.secondary(label: 'Cancel', onPressed: () {}),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });

  group('AppButton.ghost', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.ghost(label: 'Skip', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Skip'), findsOneWidget);
    });

    testWidgets('renders as TextButton', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.ghost(label: 'Skip', onPressed: () {}),
          ),
        ),
      );

      expect(find.byType(TextButton), findsOneWidget);
    });
  });
}
