import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/theme/app_theme.dart';
import 'package:flutter_casino_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_casino_platform/features/auth/presentation/screens/login_screen.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

Widget _buildTestApp({required Widget home}) {
  return MaterialApp(
    theme: AppTheme.dark,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthInitial());

    // Override GetIt factory to return mock bloc.
    if (sl.isRegistered<AuthBloc>()) {
      sl.unregister<AuthBloc>();
    }
    sl.registerFactory<AuthBloc>(() => mockAuthBloc);
  });

  tearDown(() {
    if (sl.isRegistered<AuthBloc>()) {
      sl.unregister<AuthBloc>();
    }
  });

  group('LoginScreen', () {
    testWidgets('renders Sign In button', (tester) async {
      await tester.pumpWidget(_buildTestApp(home: const LoginScreen()));
      await tester.pump();

      expect(find.text('Sign In'), findsWidgets);
    });

    testWidgets('renders email field', (tester) async {
      await tester.pumpWidget(_buildTestApp(home: const LoginScreen()));
      await tester.pump();

      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('shows email validation error when email is empty', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(home: const LoginScreen()));
      await tester.pump();

      // Tap Sign In without filling in email.
      final signInFinder = find.widgetWithText(ElevatedButton, 'Sign In');
      await tester.tap(signInFinder.first);
      await tester.pump();

      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('shows password validation error when password is empty', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(home: const LoginScreen()));
      await tester.pump();

      // Fill email, leave password empty.
      await tester.enterText(
        find.byType(TextFormField).first,
        'alice@example.com',
      );

      final signInFinder = find.widgetWithText(ElevatedButton, 'Sign In');
      await tester.tap(signInFinder.first);
      await tester.pump();

      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('shows Sign Up link', (tester) async {
      await tester.pumpWidget(_buildTestApp(home: const LoginScreen()));
      await tester.pump();

      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('shows error banner when state is AuthError', (tester) async {
      const errorMessage = 'Invalid email or password.';
      when(() => mockAuthBloc.state).thenReturn(const AuthError(errorMessage));
      whenListen(
        mockAuthBloc,
        Stream.value(const AuthError(errorMessage)),
        initialState: const AuthError(errorMessage),
      );

      await tester.pumpWidget(_buildTestApp(home: const LoginScreen()));
      await tester.pump();

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('shows loading indicator when state is AuthLoading', (
      tester,
    ) async {
      when(() => mockAuthBloc.state).thenReturn(AuthLoading());
      whenListen(
        mockAuthBloc,
        Stream.value(AuthLoading()),
        initialState: AuthLoading(),
      );

      await tester.pumpWidget(_buildTestApp(home: const LoginScreen()));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
