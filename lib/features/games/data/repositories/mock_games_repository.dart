import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/mock/mock_games.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/games/domain/repositories/games_repository.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';

/// In-memory mock implementation of [GamesRepository].
///
/// Replace with a real HTTP + cache implementation by registering
/// a different class in [InjectionContainer] — zero changes to BLoC or UI.
class MockGamesRepository implements GamesRepository {
  const MockGamesRepository();

  @override
  Future<Either<Failure, List<GameSummary>>> getAllGames() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return right(MockGames.summaries);
  }

  @override
  Future<Either<Failure, GameDetail>> getGameById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    try {
      return right(MockGames.findById(id));
    } on StateError {
      return left(NotFoundFailure('Game not found: $id'));
    }
  }
}
