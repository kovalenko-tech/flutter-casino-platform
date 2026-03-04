part of '../profile_screen.dart';

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final ColorScheme colors;
  final Color textSecondary;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.colors,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: AppRadius.lgAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colors.primary, size: AppIconSize.md),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: AppTypography.labelSmall(textSecondary)),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.labelMedium(colors.onSurface),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
