import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_casino_platform/core/constants/app_constants.dart';
import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_casino_platform/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter_casino_platform/features/games/presentation/screens/game_detail_screen.dart';
import 'package:flutter_casino_platform/features/settings/presentation/screens/change_password_screen.dart';
import 'package:flutter_casino_platform/features/settings/presentation/screens/language_screen.dart';
import 'package:flutter_casino_platform/features/settings/presentation/screens/notifications_screen.dart';
import 'package:flutter_casino_platform/features/settings/presentation/screens/theme_screen.dart';
import 'package:flutter_casino_platform/features/shell/main_shell.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/core/types/either.dart';

/// Builds the app's [GoRouter] with an auth-guard redirect.
///
/// The guard checks whether a user row exists in SQLite.
/// If no session is found, any route redirects to `/login`.
GoRouter buildRouter() {
  return GoRouter(
    initialLocation: AppConstants.routeHome,
    redirect: _authGuard,
    routes: [
      // ── Unauthenticated ─────────────────────────────────────────────────
      GoRoute(
        path: AppConstants.routeLogin,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppConstants.routeRegister,
        builder: (context, state) => const RegisterScreen(),
      ),

      // ── Settings (outside shell — no bottom nav) ────────────────────────
      GoRoute(
        path: AppConstants.routeNotifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppConstants.routeLanguage,
        builder: (context, state) => const LanguageScreen(),
      ),
      GoRoute(
        path: AppConstants.routeTheme,
        builder: (context, state) => const ThemeScreen(),
      ),
      GoRoute(
        path: AppConstants.routeChangePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),

      // ── Authenticated shell (bottom nav) ─────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => MainShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppConstants.routeHome,
                builder: (context, state) => const HomeTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppConstants.routeGames,
                builder: (context, state) => const GamesTab(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return GameDetailScreen(gameId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppConstants.routeProfile,
                builder: (context, state) => const ProfileTab(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// Redirect logic — returns the login path when no user session is found.
Future<String?> _authGuard(BuildContext context, GoRouterState state) async {
  final authRepo = sl<AuthRepository>();
  final result = await authRepo.getCurrentUser();
  final hasSession = result.isRight && result.rightValue != null;

  final isAuthRoute = state.matchedLocation == AppConstants.routeLogin ||
      state.matchedLocation == AppConstants.routeRegister;

  if (!hasSession && !isAuthRoute) {
    return AppConstants.routeLogin;
  }

  if (hasSession && isAuthRoute) {
    return AppConstants.routeHome;
  }

  return null;
}
