import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
import 'package:flutter_casino_platform/core/router/app_router.dart';
import 'package:flutter_casino_platform/core/settings/app_settings_cubit.dart';
import 'package:flutter_casino_platform/core/theme/app_theme.dart';

class CasinoApp extends StatelessWidget {
  CasinoApp({super.key});

  final _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AppSettingsCubit>(),
      child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, settings) {
          return MaterialApp.router(
            title: 'Casino Platform',
            debugShowCheckedModeBanner: false,

            // ── Theme ────────────────────────────────────────────────────────
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settings.themeMode,

            // ── Localization ─────────────────────────────────────────────────
            locale: settings.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,

            // ── Router ───────────────────────────────────────────────────────
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
