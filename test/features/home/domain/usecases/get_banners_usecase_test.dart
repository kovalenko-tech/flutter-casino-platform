import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';
import 'package:flutter_casino_platform/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_casino_platform/features/home/domain/usecases/get_banners_usecase.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late MockHomeRepository mockRepo;
  late GetBannersUseCase useCase;

  setUp(() {
    mockRepo = MockHomeRepository();
    useCase = GetBannersUseCase(mockRepo);
  });

  group('GetBannersUseCase', () {
    final testBanners = [
      const PromoBanner(
        id: '1',
        title: 'Welcome',
        subtitle: 'Get started',
        ctaLabel: 'Claim',
        imageUrl: 'https://example.com/banner.jpg',
      ),
      const PromoBanner(
        id: '2',
        title: 'Free Spins',
        subtitle: '50 free spins',
        ctaLabel: 'Spin',
        imageUrl: 'https://example.com/spins.jpg',
      ),
    ];

    test('returns banners from repository on success', () async {
      when(() => mockRepo.getBanners())
          .thenAnswer((_) async => right(testBanners));

      final result = await useCase();

      expect(result.isRight, isTrue);
      expect(result.rightValue, equals(testBanners));
      verify(() => mockRepo.getBanners()).called(1);
    });

    test('propagates StorageFailure from repository', () async {
      when(() => mockRepo.getBanners())
          .thenAnswer((_) async => left(const StorageFailure('db error')));

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.leftValue, isA<StorageFailure>());
      expect(result.leftValue.message, equals('db error'));
    });

    test('delegates exactly one call to repository', () async {
      when(() => mockRepo.getBanners())
          .thenAnswer((_) async => right(testBanners));

      await useCase();

      verify(() => mockRepo.getBanners()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
