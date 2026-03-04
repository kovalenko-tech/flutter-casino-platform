import 'package:flutter/material.dart';

import 'package:flutter_casino_platform/core/theme/app_colors_extension.dart';

/// Convenience accessor so widgets can write `context.appColors.textSecondary`
/// instead of `Theme.of(context).extension<AppColorsExtension>()!`.
extension ThemeContextExtension on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
