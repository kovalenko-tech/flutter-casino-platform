import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/presentation/bloc/home_bloc.dart';

/// Horizontal scrollable row of category filter chips.
///
/// Tapping a chip dispatches [FilterByCategory] to [HomeBloc].
class CategoryFilterChips extends StatelessWidget {
  final GameCategory selectedCategory;

  const CategoryFilterChips({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final categories = GameCategory.values;

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
            onTap: () =>
                context.read<HomeBloc>().add(FilterByCategory(cat)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? colors.primary
                    : colors.surfaceContainerHighest,
                borderRadius:
                    const BorderRadius.all(Radius.circular(999)),
                border: Border.all(
                  color: isSelected
                      ? colors.primary
                      : colors.outline,
                ),
              ),
              child: Text(
                cat.displayName,
                style: AppTypography.labelMedium(
                  isSelected ? colors.onPrimary : colors.onSurface,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
