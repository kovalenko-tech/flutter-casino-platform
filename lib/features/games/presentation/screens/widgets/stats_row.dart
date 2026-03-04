part of '../game_detail_screen.dart';

class _StatsRow extends StatelessWidget {
  final GameDetail game;

  const _StatsRow({required this.game});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textSecondary = context.appColors.textSecondary;
    final l10n = context.l10n;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StatChip(
            icon: Icons.percent,
            label: l10n.gamesRtp,
            value: '${game.rtp}%',
            colors: colors,
            textSecondary: textSecondary,
          ),
          const SizedBox(width: AppSpacing.md),
          _VolatilityChip(
            volatility: game.volatility,
            textSecondary: textSecondary,
          ),
          if (game.isNew || game.isHot) ...[
            const SizedBox(width: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: game.isHot
                    ? colors.primary.withValues(alpha: 0.15)
                    : colors.secondary.withValues(alpha: 0.15),
                borderRadius: AppRadius.mdAll,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    game.isHot
                        ? Icons.local_fire_department
                        : Icons.new_releases,
                    size: AppIconSize.sm,
                    color: game.isHot ? colors.primary : colors.secondary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    game.isHot ? l10n.badgeHot : l10n.badgeNew,
                    style: AppTypography.labelMedium(
                      game.isHot ? colors.primary : colors.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final ColorScheme colors;
  final Color textSecondary;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.colors,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: AppRadius.mdAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppIconSize.sm, color: colors.primary),
          const SizedBox(width: AppSpacing.xs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: AppTypography.labelSmall(textSecondary)),
              Text(value, style: AppTypography.labelMedium(colors.onSurface)),
            ],
          ),
        ],
      ),
    );
  }
}

class _VolatilityChip extends StatelessWidget {
  final Volatility volatility;
  final Color textSecondary;

  const _VolatilityChip({
    required this.volatility,
    required this.textSecondary,
  });

  Color get _color => switch (volatility) {
        Volatility.low => AppColors.darkSuccess,
        Volatility.medium => const Color(0xFFF59E0B),
        Volatility.high => AppColors.darkError,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: AppRadius.mdAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bar_chart_rounded, size: AppIconSize.sm, color: _color),
          const SizedBox(width: AppSpacing.xs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.gamesVolatility,
                style: AppTypography.labelSmall(textSecondary),
              ),
              Text(
                volatility.label(context.l10n),
                style: AppTypography.labelMedium(_color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
