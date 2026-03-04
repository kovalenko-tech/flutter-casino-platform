import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_casino_platform/core/constants/app_constants.dart';
import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';
import 'package:flutter_casino_platform/core/theme/app_icon_size.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/core/theme/theme_context_extension.dart';
import 'package:flutter_casino_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_casino_platform/shared/widgets/app_button.dart';
import 'package:go_router/go_router.dart';

part 'widgets/logo.dart';
part 'widgets/login_form.dart';
part 'widgets/error_banner.dart';
part 'widgets/register_link.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) context.go(AppConstants.routeHome);
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xxl),
                    const _Logo(),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      l10n.authWelcomeBack,
                      style: AppTypography.headlineLarge(colors.onSurface),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.authSignInSubtitle,
                      style: AppTypography.bodyMedium(
                        context.appColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _LoginForm(state: state),
                    const SizedBox(height: AppSpacing.lg),
                    const _RegisterLink(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
