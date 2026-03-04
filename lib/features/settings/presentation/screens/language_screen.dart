import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';
import 'package:flutter_casino_platform/core/settings/app_settings_cubit.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsLanguage)),
      body: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, state) {
          final options = [
            (const Locale('en'), l10n.languageEnglish),
            (const Locale('uk'), l10n.languageUkrainian),
            (const Locale('de'), l10n.languageGerman),
          ];

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: options.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final (locale, label) = options[index];
              final selected = state.locale.languageCode == locale.languageCode;

              return Material(
                color: colors.surfaceContainerHighest,
                borderRadius: AppRadius.mdAll,
                child: ListTile(
                  shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
                  title: Text(
                    label,
                    style: AppTypography.bodyMedium(colors.onSurface),
                  ),
                  trailing: selected
                      ? Icon(Icons.check_circle, color: colors.primary)
                      : null,
                  onTap: () {
                    context.read<AppSettingsCubit>().setLocale(locale);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
