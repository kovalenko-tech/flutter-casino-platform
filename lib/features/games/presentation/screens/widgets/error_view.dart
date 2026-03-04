part of '../game_detail_screen.dart';

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                color: colors.error, size: AppIconSize.xxl),
            const SizedBox(height: AppSpacing.md),
            Text(message, style: AppTypography.bodyMedium(colors.onSurface)),
            const SizedBox(height: AppSpacing.lg),
            AppButton.secondary(
              label: l10n.gamesGoBack,
              isFullWidth: false,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
