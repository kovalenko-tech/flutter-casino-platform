import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_casino_platform/core/constants/app_constants.dart';
import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/theme/app_icon_size.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/core/theme/theme_context_extension.dart';
import 'package:flutter_casino_platform/shared/widgets/shimmer_loader.dart';
import 'package:flutter_casino_platform/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_casino_platform/features/home/presentation/widgets/category_filter_chips.dart';
import 'package:flutter_casino_platform/features/home/presentation/widgets/game_grid.dart';
import 'package:flutter_casino_platform/features/home/presentation/widgets/hero_carousel.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';

part 'widgets/home_app_bar.dart';
part 'widgets/shimmer_carousel.dart';

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

    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final bg = context.appColors.background;

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _HomeAppBar(backgroundColor: bg),
                  if (state is HomeLoading) ...[
                    const SliverToBoxAdapter(child: _ShimmerCarousel()),
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
                              size: AppIconSize.xxl,
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
              ),
              // Gradient overlay so status bar doesn't clash with content
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Container(
                    height: MediaQuery.of(context).padding.top + AppSpacing.md,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [bg, bg.withValues(alpha: 0)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
