import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/games/domain/repositories/games_repository.dart';

/// Fetches the full [GameDetail] for a given game ID.
class GetGameDetailUseCase {
  final GamesRepository _repository;

  const GetGameDetailUseCase(this._repository);

  Future<Either<Failure, GameDetail>> call(String id) {
    return _repository.getGameById(id);
  }
}
