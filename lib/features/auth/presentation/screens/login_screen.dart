import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_button.dart';
import '../bloc/auth_bloc.dart';

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
                    const SizedBox(height: AppSpacing.xxl),
                    _buildLogo(colors),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      'Welcome back',
                      style: AppTypography.headlineLarge(colors.onSurface),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Sign in to your account',
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
          child: Icon(
            Icons.casino_rounded,
            color: colors.onPrimary,
            size: 28,
          ),
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
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Email is required';
              if (!v.contains('@')) return 'Enter a valid email';
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
              labelText: 'Password',
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
              if (v == null || v.isEmpty) return 'Password is required';
              if (v.length < 6) return 'Password must be at least 6 characters';
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton.primary(
            label: 'Sign In',
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
            child: Text(
              message,
              style: AppTypography.bodySmall(colors.error),
            ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppTypography.bodyMedium(
            isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        GestureDetector(
          onTap: () => context.push(AppConstants.routeRegister),
          child: Text(
            'Sign Up',
            style: AppTypography.labelLarge(colors.primary),
          ),
        ),
      ],
    );
  }
}
