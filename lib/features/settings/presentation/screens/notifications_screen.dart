import 'package:flutter/material.dart';

import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';
import 'package:flutter_casino_platform/core/theme/app_icon_size.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/core/theme/theme_context_extension.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    final textSecondary = context.appColors.textSecondary;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notificationsTitle)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: AppIconSize.xxl * 1.5,
              color: textSecondary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.notificationsEmpty,
              style: AppTypography.bodyLarge(colors.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
