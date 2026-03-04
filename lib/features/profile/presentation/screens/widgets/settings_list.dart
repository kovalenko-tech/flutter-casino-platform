part of '../profile_screen.dart';

class _SettingsList extends StatelessWidget {
  final ColorScheme colors;
  final Color textSecondary;

  const _SettingsList({
    required this.colors,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = [
      (
        Icons.notifications_outlined,
        l10n.profileNotifications,
        AppConstants.routeNotifications
      ),
      (
        Icons.language_outlined,
        l10n.profileLanguage,
        AppConstants.routeLanguage
      ),
      (Icons.palette_outlined, l10n.settingsTheme, AppConstants.routeTheme),
      (
        Icons.security_outlined,
        l10n.profileSecurity,
        AppConstants.routeChangePassword
      ),
    ];

    return Material(
      color: colors.surfaceContainerHighest,
      borderRadius: AppRadius.lgAll,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final (icon, label, route) = entry.value;
          return Column(
            children: [
              ListTile(
                leading:
                    Icon(icon, color: colors.onSurface, size: AppIconSize.lg),
                title: Text(
                  label,
                  style: AppTypography.bodyMedium(colors.onSurface),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: textSecondary,
                  size: AppIconSize.md,
                ),
                onTap: () => context.push(route),
              ),
              if (i < items.length - 1)
                Divider(
                  height: 1,
                  indent: AppSpacing.lg + AppIconSize.lg + AppSpacing.md,
                  color: colors.outline.withValues(alpha: 0.5),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
