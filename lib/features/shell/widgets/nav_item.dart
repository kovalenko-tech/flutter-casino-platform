part of '../main_shell.dart';

class _NavItem extends StatelessWidget {
  final _TabItem tab;
  final bool isActive;
  final ColorScheme colors;
  final Color textSecondary;

  const _NavItem({
    required this.tab,
    required this.isActive,
    required this.colors,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? colors.primary : textSecondary;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Gold top-border indicator for active tab
        if (isActive)
          Container(
            height: 2,
            width: 32,
            margin: const EdgeInsets.only(bottom: AppSpacing.xs),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: AppRadius.fullAll,
            ),
          )
        else
          const SizedBox(height: 2 + AppSpacing.xs),
        Icon(isActive ? tab.activeIcon : tab.icon,
            color: color, size: AppIconSize.lg),
        const SizedBox(height: 2),
        Text(tab.label, style: AppTypography.labelSmall(color)),
      ],
    );
  }
}
