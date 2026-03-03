import 'package:flutter/material.dart';

import 'package:flutter_casino_platform/core/mock/mock_games.dart';
import 'package:flutter_casino_platform/core/theme/app_colors.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/features/home/presentation/widgets/game_card.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';

/// Full games catalogue tab — shows all games in a 4-column grid
/// with a persistent search bar at the top.
class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final _searchController = TextEditingController();
  List<GameSummary> _filtered = MockGames.summaries;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filtered = MockGames.summaries;
      } else {
        final q = query.toLowerCase();
        _filtered =
            MockGames.summaries
                .where(
                  (g) =>
                      g.name.toLowerCase().contains(q) ||
                      g.provider.toLowerCase().contains(q),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor:
                isDark ? AppColors.darkBackground : AppColors.lightBackground,
            title: Text(
              l10n.gamesAllGames,
              style: AppTypography.titleLarge(colors.onSurface),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(64),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearch,
                  style: AppTypography.bodyMedium(colors.onSurface),
                  decoration: InputDecoration(
                    hintText: l10n.gamesSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _onSearch('');
                              },
                            )
                            : null,
                  ),
                ),
              ),
            ),
          ),
          if (_filtered.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search_off_outlined,
                      color: colors.onSurface.withOpacity(0.4),
                      size: 48,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      l10n.gamesNoResults,
                      style: AppTypography.bodyMedium(
                        colors.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.xxl,
              ),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => GameCard(game: _filtered[i]),
                  childCount: _filtered.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: AppSpacing.sm,
                  crossAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 0.75,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
