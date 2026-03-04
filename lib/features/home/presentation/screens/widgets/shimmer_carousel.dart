part of '../home_screen.dart';

class _ShimmerCarousel extends StatelessWidget {
  const _ShimmerCarousel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: ShimmerLoader.banner(),
    );
  }
}
