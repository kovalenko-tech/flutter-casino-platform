part of '../register_screen.dart';

class _LoginLink extends StatelessWidget {
  const _LoginLink();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.authAlreadyHaveAccount,
          style: AppTypography.bodyMedium(
            context.appColors.textSecondary,
          ),
        ),
        GestureDetector(
          onTap: () => context.pop(),
          child: Text(
            l10n.authSignIn,
            style: AppTypography.labelLarge(colors.primary),
          ),
        ),
      ],
    );
  }
}
