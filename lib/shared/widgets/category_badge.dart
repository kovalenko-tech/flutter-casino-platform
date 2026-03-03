import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../features/home/domain/entities/game_category.dart';

/// Coloured label chip indicating a game's category.
///
/// Each category has a distinct colour for quick visual scanning.
class CategoryBadge extends StatelessWidget {
  final GameCategory category;

  const CategoryBadge({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final (bg, fg) = _colors(isDark);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.smAll,
      ),
      child: Text(
        category.displayName,
        style: AppTypography.labelSmall(fg),
      ),
    );
  }

  (Color bg, Color fg) _colors(bool isDark) => switch (category) {
        GameCategory.all => (
            isDark ? AppColors.darkCard : AppColors.lightCard,
            isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        GameCategory.slots => (
            const Color(0x33F0B429),
            AppColors.darkPrimary,
          ),
        GameCategory.live => (
            const Color(0x33EF4444),
            AppColors.darkError,
          ),
        GameCategory.table => (
            const Color(0x3310B981),
            AppColors.darkSuccess,
          ),
        GameCategory.jackpot => (
            const Color(0x338B5CF6),
            AppColors.darkAccent,
          ),
      };
}
