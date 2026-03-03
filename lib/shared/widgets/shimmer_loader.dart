import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

/// Shimmer-based loading placeholders for common UI patterns.
///
/// Usage:
/// ```dart
/// ShimmerLoader.grid()    // 8-tile game grid placeholder
/// ShimmerLoader.banner()  // hero carousel placeholder
/// ShimmerLoader.card()    // single card placeholder
/// ```
class ShimmerLoader extends StatelessWidget {
  final Widget child;

  const ShimmerLoader({super.key, required this.child});

  factory ShimmerLoader.grid({int itemCount = 8}) => ShimmerLoader(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: AppSpacing.sm,
            crossAxisSpacing: AppSpacing.sm,
            childAspectRatio: 0.75,
          ),
          itemCount: itemCount,
          itemBuilder: (_, __) => const _ShimmerBox(
            borderRadius: AppRadius.mdAll,
          ),
        ),
      );

  factory ShimmerLoader.banner() => const ShimmerLoader(
        child: _ShimmerBox(
          height: 200,
          borderRadius: AppRadius.lgAll,
        ),
      );

  factory ShimmerLoader.card({double? height}) => ShimmerLoader(
        child: _ShimmerBox(
          height: height ?? 100,
          borderRadius: AppRadius.lgAll,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkCard : const Color(0xFFE5E5E5),
      highlightColor: isDark ? AppColors.darkSurface : const Color(0xFFF5F5F5),
      child: child,
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double? height;
  final BorderRadius borderRadius;

  const _ShimmerBox({
    this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
    );
  }
}
