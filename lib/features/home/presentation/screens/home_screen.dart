import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/theme/app_colors.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/shared/widgets/shimmer_loader.dart';
import 'package:flutter_casino_platform/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_casino_platform/features/home/presentation/widgets/category_filter_chips.dart';
import 'package:flutter_casino_platform/features/home/presentation/widgets/game_grid.dart';
import 'package:flutter_casino_platform/features/home/presentation/widgets/hero_carousel.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';

/// Home tab — entry screen for the authenticated experience.
///
/// Layout (top to bottom, inside a [CustomScrollView]):
///   - AppBar: logo + notification icon
///   - Hero carousel
///   - Section title: "All Games"
///   - Category filter chips
///   - Game grid (4 columns)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const LoadHomeData()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              _buildAppBar(colors, isDark, l10n),
              if (state is HomeLoading) ...[
                SliverToBoxAdapter(child: _shimmerCarousel()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: ShimmerLoader.grid(),
                  ),
                ),
              ] else if (state is HomeLoaded) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    child: HeroCarousel(banners: state.banners),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.lg,
                      AppSpacing.md,
                      AppSpacing.sm,
                    ),
                    child: Text(
                      l10n.gamesAllGames,
                      style: AppTypography.headlineSmall(colors.onSurface),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CategoryFilterChips(
                    selectedCategory: state.selectedCategory,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.md),
                ),
                GameGrid(games: state.games),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xxl),
                ),
              ] else if (state is HomeError) ...[
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: colors.error,
                          size: 48,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          state.message,
                          style: AppTypography.bodyMedium(colors.onSurface),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        TextButton(
                          onPressed: () => context.read<HomeBloc>().add(
                                const LoadHomeData(),
                              ),
                          child: Text(l10n.retry),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  SliverAppBar _buildAppBar(
    ColorScheme colors,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Icon(
              Icons.casino_rounded,
              color: colors.onPrimary,
              size: 18,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            l10n.homeTitle,
            style: AppTypography.titleLarge(colors.onSurface),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: colors.onSurface),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _shimmerCarousel() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: ShimmerLoader.banner(),
    );
  }
}
