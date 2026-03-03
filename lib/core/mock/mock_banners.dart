/// Promotional banner data for the home screen hero carousel.
///
/// In production these would be fetched from a CMS and cached locally.
class PromoBanner {
  final String id;
  final String title;
  final String subtitle;
  final String ctaLabel;
  final String imageUrl;

  const PromoBanner({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.imageUrl,
  });
}

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
