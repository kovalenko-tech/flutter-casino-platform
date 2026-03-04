part of '../game_detail_screen.dart';

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(expandedHeight: 240, flexibleSpace: FlexibleSpaceBar()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ShimmerLoader.card(height: 200),
          ),
        ),
      ],
    );
  }
}
