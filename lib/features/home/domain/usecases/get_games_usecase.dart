import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/domain/repositories/home_repository.dart';

/// Retrieves the game catalogue, with optional category filtering.
class GetGamesUseCase {
  final HomeRepository _repository;

  const GetGamesUseCase(this._repository);

  Future<Either<Failure, List<GameSummary>>> call({
    GameCategory category = GameCategory.all,
  }) {
    return _repository.getGames(category: category);
  }
}
