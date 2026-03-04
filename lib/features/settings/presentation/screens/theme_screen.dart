import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';
import 'package:flutter_casino_platform/core/settings/app_settings_cubit.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTheme)),
      body: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, state) {
          final options = [
            (ThemeMode.system, l10n.themeSystem, Icons.settings_brightness),
            (ThemeMode.light, l10n.themeLight, Icons.light_mode_outlined),
            (ThemeMode.dark, l10n.themeDark, Icons.dark_mode_outlined),
          ];

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: options.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final (mode, label, icon) = options[index];
              final selected = state.themeMode == mode;

              return Material(
                color: colors.surfaceContainerHighest,
                borderRadius: AppRadius.mdAll,
                child: ListTile(
                  shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
                  leading: Icon(icon, color: colors.onSurface),
                  title: Text(
                    label,
                    style: AppTypography.bodyMedium(colors.onSurface),
                  ),
                  trailing: selected
                      ? Icon(Icons.check_circle, color: colors.primary)
                      : null,
                  onTap: () {
                    context.read<AppSettingsCubit>().setThemeMode(mode);
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
