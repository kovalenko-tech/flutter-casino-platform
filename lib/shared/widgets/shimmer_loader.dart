import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/theme_context_extension.dart';

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
          itemBuilder: (_, __) =>
              const _ShimmerBox(borderRadius: AppRadius.mdAll),
        ),
      );

  factory ShimmerLoader.banner() => const ShimmerLoader(
        child: _ShimmerBox(height: 200, borderRadius: AppRadius.lgAll),
      );

  factory ShimmerLoader.card({double? height}) => ShimmerLoader(
        child:
            _ShimmerBox(height: height ?? 100, borderRadius: AppRadius.lgAll),
      );

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Shimmer.fromColors(
      baseColor: appColors.card,
      highlightColor: appColors.background,
      child: child,
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double? height;
  final BorderRadius borderRadius;

  const _ShimmerBox({this.height, required this.borderRadius});

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
