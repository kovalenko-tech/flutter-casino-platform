import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_casino_platform/core/theme/app_icon_size.dart';
import 'package:flutter_casino_platform/core/theme/theme_context_extension.dart';

/// Reusable network image with shimmer placeholder while loading.
///
/// Usage:
/// ```dart
/// ShimmerImage(imageUrl: url, fit: BoxFit.cover)
/// ```
class ShimmerImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ShimmerImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (_, __) => Shimmer.fromColors(
        baseColor: appColors.card,
        highlightColor: appColors.background,
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      ),
      errorWidget: (_, __, ___) => Container(
        width: width,
        height: height,
        color: appColors.card,
        child: const Icon(
          Icons.image_not_supported_outlined,
          size: AppIconSize.lg,
        ),
      ),
    );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }
}
