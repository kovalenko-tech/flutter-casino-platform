import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_casino_platform/core/constants/app_constants.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/shared/widgets/app_button.dart';
import 'package:flutter_casino_platform/shared/widgets/shimmer_image.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';

/// Auto-scrolling promotional banner carousel.
///
/// Advances to the next slide every [AppConstants.autoScrollIntervalSeconds]
/// seconds. Dots indicator reflects the current page.
class HeroCarousel extends StatefulWidget {
  final List<PromoBanner> banners;

  const HeroCarousel({super.key, required this.banners});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _controller;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: AppConstants.autoScrollIntervalSeconds),
      (_) {
        if (!mounted) return;
        final next = (_currentPage + 1) % widget.banners.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  void _stopAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onPanDown: (_) => _stopAutoScroll(),
          onPanEnd: (_) => _startAutoScroll(),
          onPanCancel: _startAutoScroll,
          child: SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (p) => setState(() => _currentPage = p),
              itemCount: widget.banners.length,
              itemBuilder: (_, i) => _BannerSlide(banner: widget.banners[i]),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _DotsIndicator(count: widget.banners.length, current: _currentPage),
      ],
    );
  }
}

class _BannerSlide extends StatelessWidget {
  final PromoBanner banner;

  const _BannerSlide({required this.banner});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: ClipRRect(
        borderRadius: AppRadius.lgAll,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            ShimmerImage(imageUrl: banner.imageUrl, fit: BoxFit.cover),

            // Gradient overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.85)
                  ],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: AppRadius.smAll,
                    ),
                    child: Text(
                      'PROMO',
                      style: AppTypography.labelSmall(colors.onPrimary),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    banner.title,
                    style: AppTypography.headlineMedium(Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    banner.subtitle,
                    style: AppTypography.bodySmall(Colors.white70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton.primary(
                    label: banner.ctaLabel,
                    isFullWidth: false,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int current;

  const _DotsIndicator({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive
                ? colors.primary
                : colors.onSurface.withValues(alpha: 0.25),
            borderRadius: AppRadius.fullAll,
          ),
        );
      }),
    );
  }
}
