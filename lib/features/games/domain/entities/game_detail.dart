import 'package:equatable/equatable.dart';

import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';

/// Volatility level of a slot or game.
/// Volatility level of a slot or game.
///
/// Display labels are handled in the presentation layer via
/// [VolatilityL10n] extension to support localization.
enum Volatility { low, medium, high }

/// Full game entity — loaded when the user opens a game detail screen.
class GameDetail extends Equatable {
  final String id;
  final String name;
  final GameCategory category;
  final String provider;
  final String description;
  final double rtp;
  final Volatility volatility;
  final String imageUrl;
  final bool isNew;
  final bool isHot;

  const GameDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.provider,
    required this.description,
    required this.rtp,
    required this.volatility,
    required this.imageUrl,
    this.isNew = false,
    this.isHot = false,
  });

  /// Downcasts to a [GameSummary] for use in list/grid widgets.
  GameSummary toSummary() => GameSummary(
        id: id,
        name: name,
        category: category,
        provider: provider,
        imageUrl: imageUrl,
        isNew: isNew,
        isHot: isHot,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        provider,
        description,
        rtp,
        volatility,
        imageUrl,
        isNew,
        isHot,
      ];
}
