import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_casino_platform/core/constants/app_constants.dart';
import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';
import 'package:flutter_casino_platform/core/theme/app_colors.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_casino_platform/shared/widgets/app_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(LoginRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                    _buildLogo(colors),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      l10n.authWelcomeBack,
                      style: AppTypography.headlineLarge(colors.onSurface),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.authSignInSubtitle,
                      style: AppTypography.bodyMedium(
                        isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _buildForm(context, state, colors, isDark),
                    const SizedBox(height: AppSpacing.lg),
                    _buildRegisterLink(context, colors, isDark),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo(ColorScheme colors) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: AppRadius.mdAll,
          ),
          child: Icon(Icons.casino_rounded, color: colors.onPrimary, size: 28),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          AppConstants.appName,
          style: AppTypography.headlineSmall(colors.onSurface),
        ),
      ],
    );
  }

  Widget _buildForm(
    BuildContext context,
    AuthState state,
    ColorScheme colors,
    bool isDark,
  ) {
    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (state is AuthError) ...[
            _buildErrorBanner(state.message, colors),
            const SizedBox(height: AppSpacing.md),
          ],
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: AppTypography.bodyMedium(colors.onSurface),
            decoration: InputDecoration(
              labelText: l10n.fieldEmail,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return l10n.validationEmailRequired;
              if (!v.contains('@')) return l10n.validationEmailInvalid;
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(context),
            style: AppTypography.bodyMedium(colors.onSurface),
            decoration: InputDecoration(
              labelText: l10n.fieldPassword,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return l10n.validationPasswordRequired;
              if (v.length < 6) return l10n.validationPasswordMinLength(6);
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton.primary(
            label: l10n.authSignIn,
            isLoading: state is AuthLoading,
            onPressed: () => _submit(context),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner(String message, ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.error.withOpacity(0.12),
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: colors.error.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colors.error, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(message, style: AppTypography.bodySmall(colors.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterLink(
    BuildContext context,
    ColorScheme colors,
    bool isDark,
  ) {
    final l10n = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.authDontHaveAccount,
          style: AppTypography.bodyMedium(
            isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
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
