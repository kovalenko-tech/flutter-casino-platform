import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';

/// Presentation-layer extension that maps [Volatility] values
/// to localized display labels.
extension VolatilityL10n on Volatility {
  String label(AppLocalizations l10n) => switch (this) {
    Volatility.low => l10n.volatilityLow,
    Volatility.medium => l10n.volatilityMedium,
    Volatility.high => l10n.volatilityHigh,
  };
}
