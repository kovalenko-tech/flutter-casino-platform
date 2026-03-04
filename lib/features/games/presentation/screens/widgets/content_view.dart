part of '../game_detail_screen.dart';

class _ContentView extends StatefulWidget {
  final GameDetail game;

  const _ContentView({required this.game});

  @override
  State<_ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<_ContentView> {
  final _scrollController = ScrollController();
  bool _isCollapsed = false;

  static const _expandedHeight = 240.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final threshold =
        _expandedHeight - kToolbarHeight - MediaQuery.of(context).padding.top;
    final collapsed =
        _scrollController.hasClients && _scrollController.offset > threshold;
    if (collapsed != _isCollapsed) {
      setState(() => _isCollapsed = collapsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final appColors = context.appColors;
    final textSecondary = appColors.textSecondary;
    final l10n = context.l10n;
    final game = widget.game;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // ── Hero image with back button ────────────────────────────────────
        SliverAppBar(
          expandedHeight: _expandedHeight,
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: appColors.background,
          systemOverlayStyle: (_isCollapsed && !isDark)
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                ShimmerImage(imageUrl: game.imageUrl, fit: BoxFit.cover),
                // Top gradient (status bar legibility)
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.3],
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
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: AppRadius.fullAll,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: AppIconSize.md,
                ),
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
                Text(
                  game.name,
                  style: AppTypography.headlineLarge(colors.onSurface),
                ),
                const SizedBox(height: AppSpacing.sm),
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
                _StatsRow(game: game),
                const SizedBox(height: AppSpacing.lg),
                Divider(color: colors.outline),
                const SizedBox(height: AppSpacing.md),
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
                AppButton.primary(
                  label: l10n.gamesPlayNow,
                  prefixIcon: Icons.play_arrow_rounded,
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.md),
                AppButton.secondary(label: l10n.gamesTryDemo, onPressed: () {}),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
