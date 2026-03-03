import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
import 'package:flutter_casino_platform/core/router/app_router.dart';
import 'package:flutter_casino_platform/core/theme/app_theme.dart';

/// Root application widget.
///
/// Wires together the router, theme, and localization delegates.
/// ThemeMode follows the system setting — both dark (Velvet & Gold)
/// and light variants are fully themed via design tokens.
class CasinoApp extends StatelessWidget {
  CasinoApp({super.key});

  final _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Casino Platform',
      debugShowCheckedModeBanner: false,

      // ── Theme ──────────────────────────────────────────────────────────────
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      // ── Localization ───────────────────────────────────────────────────────
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      // ── Router ─────────────────────────────────────────────────────────────
      routerConfig: _router,
    );
  }
}
