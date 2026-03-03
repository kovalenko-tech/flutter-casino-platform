import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';

/// Contract for games catalogue data access.
///
/// The domain layer only talks to this interface.
/// Switch from [MockGamesRepository] to a real implementation
/// by registering a different class in the DI container.
abstract interface class GamesRepository {
  /// Returns the full game catalogue as lightweight summaries.
  Future<Either<Failure, List<GameSummary>>> getAllGames();

  /// Returns the full [GameDetail] for the given [id].
  /// Emits [NotFoundFailure] if the game does not exist.
  Future<Either<Failure, GameDetail>> getGameById(String id);
}
