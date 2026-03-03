import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/theme/app_colors.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/shared/widgets/app_button.dart';
import 'package:flutter_casino_platform/shared/widgets/category_badge.dart';
import 'package:flutter_casino_platform/shared/widgets/shimmer_loader.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/games/presentation/bloc/game_detail_bloc.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';
import 'package:flutter_casino_platform/shared/extensions/volatility_l10n.dart';

class GameDetailScreen extends StatelessWidget {
  final String gameId;

  const GameDetailScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => sl<GameDetailBloc>()..add(LoadGameDetail(gameId)),
      child: const _GameDetailView(),
    );
  }
}

class _GameDetailView extends StatelessWidget {
  const _GameDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameDetailBloc, GameDetailState>(
        builder: (context, state) {
          return switch (state) {
            GameDetailLoading() => _buildLoading(),
            GameDetailLoaded(:final game) => _buildContent(context, game),
            GameDetailError(:final message) => _buildError(context, message),
          };
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(expandedHeight: 240, flexibleSpace: FlexibleSpaceBar()),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: ShimmerLoader.card == ShimmerLoader.card
                ? SizedBox(height: 200)
                : SizedBox(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, GameDetail game) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return CustomScrollView(
      slivers: [
        // ── Hero image with back button ────────────────────────────────────
        SliverAppBar(
          expandedHeight: 240,
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: isDark
              ? AppColors.darkBackground
              : AppColors.lightBackground,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: game.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      Container(color: AppColors.darkCard),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.darkCard,
                    child: const Icon(
                      Icons.sports_esports_outlined,
                      size: 48,
                    ),
                  ),
                ),
                // Bottom gradient
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xCC000000)],
                      stops: [0.5, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: AppRadius.fullAll,
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 20),
              ),
            ),
          ),
        ),

        // ── Content ────────────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  game.name,
                  style: AppTypography.headlineLarge(colors.onSurface),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Category + Provider row
                Row(
                  children: [
                    CategoryBadge(category: game.category),
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: colors.outline),
                        borderRadius: AppRadius.smAll,
                      ),
                      child: Text(
                        game.provider,
                        style: AppTypography.labelSmall(textSecondary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Stats row
                _buildStatsRow(game, colors, textSecondary, l10n),
                const SizedBox(height: AppSpacing.lg),

                // Divider
                Divider(color: colors.outline),
                const SizedBox(height: AppSpacing.md),

                // Description
                Text(
                  l10n.gamesAbout,
                  style: AppTypography.titleLarge(colors.onSurface),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  game.description,
                  style: AppTypography.bodyMedium(textSecondary),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // CTA
                AppButton.primary(
                  label: l10n.gamesPlayNow,
                  prefixIcon: Icons.play_arrow_rounded,
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.md),
                AppButton.secondary(
                  label: l10n.gamesTryDemo,
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(
    GameDetail game,
    ColorScheme colors,
    Color textSecondary,
    AppLocalizations l10n,
  ) {
    return Row(
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
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: game.isHot
                  ? colors.primary.withOpacity(0.15)
                  : colors.secondary.withOpacity(0.15),
              borderRadius: AppRadius.smAll,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  game.isHot ? Icons.local_fire_department : Icons.new_releases,
                  size: 14,
                  color: game.isHot ? colors.primary : colors.secondary,
                ),
                const SizedBox(width: 4),
                Text(
                  game.isHot ? 'HOT' : 'NEW',
                  style: AppTypography.labelSmall(
                    game.isHot ? colors.primary : colors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildError(BuildContext context, String message) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: colors.error, size: 48),
            const SizedBox(height: AppSpacing.md),
            Text(message, style: AppTypography.bodyMedium(colors.onSurface)),
            const SizedBox(height: AppSpacing.lg),
            AppButton.secondary(
              label: l10n.gamesGoBack,
              isFullWidth: false,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────

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
          Icon(icon, size: 16, color: colors.primary),
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
        color: _color.withOpacity(0.12),
        borderRadius: AppRadius.mdAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bar_chart_rounded, size: 16, color: _color),
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
