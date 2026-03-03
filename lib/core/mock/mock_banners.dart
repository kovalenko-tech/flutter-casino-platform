import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';

/// Static promotional banner data for the home screen hero carousel.
///
/// In production these would be fetched from a CMS and cached locally.
/// All fields map directly to the [PromoBanner] domain entity.
abstract final class MockBanners {
  static const List<PromoBanner> all = [
    PromoBanner(
      id: 'welcome-bonus',
      title: 'Welcome Bonus',
      subtitle: '200% up to \$500 on your first deposit',
      ctaLabel: 'Claim Now',
      imageUrl: 'https://picsum.photos/seed/welcome/800/400',
    ),
    PromoBanner(
      id: 'free-spins',
      title: '50 Free Spins',
      subtitle: 'Exclusively on Gates of Olympus',
      ctaLabel: 'Spin Now',
      imageUrl: 'https://picsum.photos/seed/freespins/800/400',
    ),
    PromoBanner(
      id: 'vip-tournament',
      title: 'VIP Weekend Tournament',
      subtitle: '\$10,000 Prize Pool — Top 20 Win Big',
      ctaLabel: 'Join Tournament',
      imageUrl: 'https://picsum.photos/seed/viptourney/800/400',
    ),
  ];
}
