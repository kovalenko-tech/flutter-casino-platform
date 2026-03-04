import 'package:flutter/material.dart';
import 'package:flutter_casino_platform/core/constants/app_constants.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/shared/extensions/game_category_l10n.dart';
import 'package:flutter_casino_platform/shared/widgets/shimmer_image.dart';
import 'package:go_router/go_router.dart';

/// Individual game tile rendered inside the home game grid.
///
/// Shows the cover image, game name, and overlays a "NEW" or "HOT" badge
/// in the top corner when applicable.
class GameCard extends StatefulWidget {
  final GameSummary game;

  const GameCard({super.key, required this.game});

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    context.push('${AppConstants.routeGames}/${widget.game.id}');
  }

  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final game = widget.game;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scale,
        child: ClipRRect(
          borderRadius: AppRadius.mdAll,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Cover image with shimmer placeholder
              ShimmerImage(imageUrl: game.imageUrl, fit: BoxFit.cover),

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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          game.name,
                          style: AppTypography.labelSmall(Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          game.category.label(context.l10n),
                          style: AppTypography.labelSmall(
                            Colors.white.withValues(alpha: 0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
        isNew ? context.l10n.badgeNew : context.l10n.badgeHot,
        style: AppTypography.labelSmall(
          isNew ? Colors.white : colors.onPrimary,
        ),
      ),
    );
  }
}
