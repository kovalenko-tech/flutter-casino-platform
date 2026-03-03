import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_casino_platform/core/constants/app_constants.dart';
import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/theme/app_colors.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/shared/widgets/app_button.dart';
import 'package:flutter_casino_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            RegisterRequested(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          );
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
          if (state is Authenticated) {
            context.go(AppConstants.routeHome);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    _buildBackButton(context, colors),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.authCreateAccount,
                      style: AppTypography.headlineLarge(colors.onSurface),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.authJoinSubtitle,
                      style: AppTypography.bodyMedium(
                        isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _buildForm(context, state, colors, isDark),
                    const SizedBox(height: AppSpacing.lg),
                    _buildLoginLink(context, colors, isDark),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, ColorScheme colors) {
    final l10n = context.l10n;
    return GestureDetector(
      onTap: () => context.pop(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios, color: colors.onSurface, size: 18),
          const SizedBox(width: AppSpacing.xs),
          Text(l10n.back, style: AppTypography.bodyMedium(colors.onSurface)),
        ],
      ),
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
            controller: _nameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            style: AppTypography.bodyMedium(colors.onSurface),
            decoration: InputDecoration(
              labelText: l10n.fieldFullName,
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty)
                return l10n.validationNameRequired;
              if (v.trim().length < 2) return l10n.validationNameTooShort;
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: AppTypography.bodyMedium(colors.onSurface),
            decoration: InputDecoration(
              labelText: l10n.fieldEmail,
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return l10n.validationEmailRequired;
              if (!v.contains('@') || !v.contains('.')) {
                return l10n.validationEmailInvalid;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
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
              if (v == null || v.isEmpty)
                return l10n.validationPasswordRequired;
              if (v.length < 8) return l10n.validationPasswordMinLength(8);
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _confirmController,
            obscureText: _obscureConfirm,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(context),
            style: AppTypography.bodyMedium(colors.onSurface),
            decoration: InputDecoration(
              labelText: l10n.fieldConfirmPassword,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty)
                return l10n.validationConfirmPasswordRequired;
              if (v != _passwordController.text) {
                return l10n.validationPasswordsDoNotMatch;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton.primary(
            label: l10n.authCreateAccount,
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

  Widget _buildLoginLink(
    BuildContext context,
    ColorScheme colors,
    bool isDark,
  ) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.authAlreadyHaveAccount,
          style: AppTypography.bodyMedium(
            isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
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
