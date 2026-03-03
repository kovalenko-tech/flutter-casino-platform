import 'package:equatable/equatable.dart';

import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';

/// Lightweight game entity for grid and list views.
///
/// Only carries the fields needed for display in the home catalogue.
/// Full details are loaded on demand via [GameDetail].
class GameSummary extends Equatable {
  final String id;
  final String name;
  final GameCategory category;
  final String provider;
  final String imageUrl;
  final bool isNew;
  final bool isHot;

  const GameSummary({
    required this.id,
    required this.name,
    required this.category,
    required this.provider,
    required this.imageUrl,
    this.isNew = false,
    this.isHot = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        provider,
        imageUrl,
        isNew,
        isHot,
      ];
}
