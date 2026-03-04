part of '../login_screen.dart';

class _RegisterLink extends StatelessWidget {
  const _RegisterLink();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.authDontHaveAccount,
          style: AppTypography.bodyMedium(
            context.appColors.textSecondary,
          ),
        ),
        GestureDetector(
          onTap: () => context.push(AppConstants.routeRegister),
          child: Text(
            l10n.authSignUp,
            style: AppTypography.labelLarge(colors.primary),
          ),
        ),
      ],
    );
  }
}
