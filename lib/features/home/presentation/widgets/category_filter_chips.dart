import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/core/theme/theme_context_extension.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_casino_platform/shared/extensions/game_category_l10n.dart';

/// Horizontal scrollable row of category filter chips.
///
/// Tapping a chip dispatches [FilterByCategory] to [HomeBloc].
class CategoryFilterChips extends StatelessWidget {
  final GameCategory selectedCategory;

  const CategoryFilterChips({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final appColors = context.appColors;
    const categories = GameCategory.values;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) {
          final cat = categories[i];
          final isSelected = cat == selectedCategory;

          return GestureDetector(
            onTap: () => context.read<HomeBloc>().add(FilterByCategory(cat)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                color: isSelected ? colors.primary : appColors.card,
                borderRadius: const BorderRadius.all(Radius.circular(999)),
              ),
              child: Text(
                cat.label(context.l10n),
                style: AppTypography.labelMedium(
                  isSelected ? colors.onPrimary : appColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
