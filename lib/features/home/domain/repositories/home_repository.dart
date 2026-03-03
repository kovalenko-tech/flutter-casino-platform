import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';

/// Contract for home screen data access.
///
/// The domain layer only talks to this interface.
/// Swap [MockHomeRepository] for a real API-backed implementation
/// by changing a single line in the DI container.
abstract interface class HomeRepository {
  /// Returns all promotional banners for the hero carousel.
  Future<Either<Failure, List<PromoBanner>>> getBanners();

  /// Returns the game catalogue, optionally filtered by [category].
  /// Passing [GameCategory.all] returns the full list.
  Future<Either<Failure, List<GameSummary>>> getGames({
    GameCategory category = GameCategory.all,
  });
}
