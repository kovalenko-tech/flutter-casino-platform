part of '../profile_screen.dart';

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          ShimmerLoader.card(height: 120),
          const SizedBox(height: AppSpacing.md),
          ShimmerLoader.card(height: 80),
          const SizedBox(height: AppSpacing.md),
          ShimmerLoader.card(height: 200),
        ],
      ),
    );
  }
}
