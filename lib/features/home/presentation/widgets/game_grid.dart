import 'package:flutter/material.dart';

import 'package:flutter_casino_platform/core/constants/app_constants.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'game_card.dart';

/// 4-column game grid rendered inside a [CustomScrollView] sliver.
class GameGrid extends StatelessWidget {
  final List<GameSummary> games;

  const GameGrid({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, i) => GameCard(game: games[i]),
          childCount: games.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppConstants.gameGridCrossAxisCount,
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 0.75,
        ),
      ),
    );
  }
}
