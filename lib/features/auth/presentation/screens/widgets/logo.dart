part of '../login_screen.dart';

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: AppRadius.mdAll,
          ),
          child: Icon(Icons.casino_rounded, color: colors.onPrimary, size: AppIconSize.lg),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          AppConstants.appName,
          style: AppTypography.headlineSmall(colors.onSurface),
        ),
      ],
    );
  }
}
