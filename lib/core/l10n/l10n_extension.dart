import 'package:flutter/widgets.dart';

import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';

/// Shortcut extension — use [context.l10n] instead of
/// [AppLocalizations.of(context)] throughout the widget tree.
///
/// Example:
/// ```dart
/// Text(context.l10n.authSignIn)
/// ```
extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
