import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/game_summary.dart';

/// Individual game tile rendered inside the home game grid.
///
/// Shows the cover image, game name, and overlays a "NEW" or "HOT" badge
/// in the top corner when applicable.
class GameCard extends StatelessWidget {
  final GameSummary game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.push('${AppConstants.routeGames}/${game.id}'),
      child: ClipRRect(
        borderRadius: AppRadius.mdAll,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Cover image
            CachedNetworkImage(
              imageUrl: game.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                color: AppColors.darkCard,
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                color: AppColors.darkCard,
                child: const Icon(Icons.sports_esports_outlined, size: 28),
              ),
            ),

            // Bottom gradient + name
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xCC000000)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  child: Text(
                    game.name,
                    style: AppTypography.labelSmall(Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            // Badge overlay (New / Hot)
            if (game.isNew || game.isHot)
              Positioned(
                top: AppSpacing.xs,
                left: AppSpacing.xs,
                child: _Badge(isNew: game.isNew, colors: colors),
              ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final bool isNew;
  final ColorScheme colors;

  const _Badge({required this.isNew, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: isNew ? colors.secondary : colors.primary,
        borderRadius: AppRadius.smAll,
      ),
      child: Text(
        isNew ? 'NEW' : 'HOT',
        style: AppTypography.labelSmall(
          isNew ? Colors.white : colors.onPrimary,
        ),
      ),
    );
  }
}
