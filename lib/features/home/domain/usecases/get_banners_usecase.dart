import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';
import 'package:flutter_casino_platform/features/home/domain/repositories/home_repository.dart';

/// Retrieves promotional banners for the home carousel.
class GetBannersUseCase {
  final HomeRepository _repository;

  const GetBannersUseCase(this._repository);

  Future<Either<Failure, List<PromoBanner>>> call() {
    return _repository.getBanners();
  }
}
