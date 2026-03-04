import 'package:flutter/material.dart';

import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:flutter_casino_platform/shared/widgets/app_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    final authRepo = sl<AuthRepository>();
    final userResult = await authRepo.getCurrentUser();
    if (!userResult.isRight || userResult.rightValue == null) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = context.l10n.errorGeneric;
      });
      return;
    }

    final email = userResult.rightValue!.email;
    final useCase = sl<ChangePasswordUseCase>();
    final result = await useCase(
      email: email,
      oldPassword: _currentController.text,
      newPassword: _newController.text,
    );

    if (!mounted) return;

    if (result.isRight) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.passwordChangeSuccess)),
      );
      Navigator.of(context).pop();
    } else {
      setState(() {
        _loading = false;
        _error = result.leftValue.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.changePassword)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_error != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: colors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _error!,
                    style: AppTypography.bodyMedium(colors.error),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              TextFormField(
                controller: _currentController,
                obscureText: _obscureCurrent,
                textInputAction: TextInputAction.next,
                style: AppTypography.bodyMedium(colors.onSurface),
                decoration: InputDecoration(
                  labelText: l10n.fieldCurrentPassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureCurrent
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () =>
                        setState(() => _obscureCurrent = !_obscureCurrent),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return l10n.validationCurrentPasswordRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _newController,
                obscureText: _obscureNew,
                textInputAction: TextInputAction.next,
                style: AppTypography.bodyMedium(colors.onSurface),
                decoration: InputDecoration(
                  labelText: l10n.fieldNewPassword,
                  helperText: l10n.passwordRequirementsHint,
                  helperMaxLines: 2,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNew
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () => setState(() => _obscureNew = !_obscureNew),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return l10n.validationPasswordRequired;
                  }
                  if (v.length < 8) return l10n.validationPasswordMinLength(8);
                  if (!v.contains(RegExp(r'[A-Z]'))) {
                    return l10n.validationPasswordUppercase;
                  }
                  if (!v.contains(RegExp(r'[a-z]'))) {
                    return l10n.validationPasswordLowercase;
                  }
                  if (!v.contains(RegExp(r'[0-9]'))) {
                    return l10n.validationPasswordDigit;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _confirmController,
                obscureText: _obscureConfirm,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                style: AppTypography.bodyMedium(colors.onSurface),
                decoration: InputDecoration(
                  labelText: l10n.fieldConfirmNewPassword,
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
                  if (v == null || v.isEmpty) {
                    return l10n.validationConfirmPasswordRequired;
                  }
                  if (v != _newController.text) {
                    return l10n.validationPasswordsDoNotMatch;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton.primary(
                label: l10n.changePassword,
                isLoading: _loading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
