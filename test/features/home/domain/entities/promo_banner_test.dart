import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';

void main() {
  group('PromoBanner', () {
    const bannerA = PromoBanner(
      id: 'welcome-bonus',
      title: 'Welcome Bonus',
      subtitle: '200% up to \$500 on your first deposit',
      ctaLabel: 'Claim Now',
      imageUrl: 'https://example.com/banner.jpg',
    );

    const bannerACopy = PromoBanner(
      id: 'welcome-bonus',
      title: 'Welcome Bonus',
      subtitle: '200% up to \$500 on your first deposit',
      ctaLabel: 'Claim Now',
      imageUrl: 'https://example.com/banner.jpg',
    );

    const bannerB = PromoBanner(
      id: 'free-spins',
      title: '50 Free Spins',
      subtitle: 'Exclusively on Gates of Olympus',
      ctaLabel: 'Spin Now',
      imageUrl: 'https://example.com/spins.jpg',
    );

    test('two PromoBanners with same fields are equal', () {
      expect(bannerA, equals(bannerACopy));
    });

    test('PromoBanners with different id are not equal', () {
      expect(bannerA, isNot(equals(bannerB)));
    });

    test('hashCode is equal for two equal PromoBanners', () {
      expect(bannerA.hashCode, equals(bannerACopy.hashCode));
    });

    test('props list includes all fields', () {
      expect(
        bannerA.props,
        equals([
          bannerA.id,
          bannerA.title,
          bannerA.subtitle,
          bannerA.ctaLabel,
          bannerA.imageUrl,
        ]),
      );
    });
  });
}
