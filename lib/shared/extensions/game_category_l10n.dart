import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';

/// Presentation-layer extension that maps [GameCategory] values
/// to localized display labels.
///
/// Keeping this out of the domain entity ensures the domain layer
/// has no dependency on the localization framework.
extension GameCategoryL10n on GameCategory {
  String label(AppLocalizations l10n) => switch (this) {
        GameCategory.all => l10n.categoryAll,
        GameCategory.slots => l10n.categorySlots,
        GameCategory.live => l10n.categoryLive,
        GameCategory.table => l10n.categoryTable,
        GameCategory.jackpot => l10n.categoryJackpot,
      };
}
