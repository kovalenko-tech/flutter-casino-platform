import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/mock/mock_banners.dart';
import 'package:flutter_casino_platform/core/mock/mock_games.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';
import 'package:flutter_casino_platform/features/home/domain/repositories/home_repository.dart';

/// In-memory mock implementation of [HomeRepository].
///
/// Serves static data defined in the mock catalogue.
/// Replace with a real HTTP + cache implementation by registering
/// a different class in [InjectionContainer] — zero changes to BLoC or UI.
class MockHomeRepository implements HomeRepository {
  const MockHomeRepository();

  @override
  Future<Either<Failure, List<PromoBanner>>> getBanners() async {
    // Simulate network latency so loading states are visible during dev.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return right(MockBanners.all);
  }

  @override
  Future<Either<Failure, List<GameSummary>>> getGames({
    GameCategory category = GameCategory.all,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final all = MockGames.summaries;
    if (category == GameCategory.all) return right(all);
    return right(all.where((g) => g.category == category).toList());
  }
}
