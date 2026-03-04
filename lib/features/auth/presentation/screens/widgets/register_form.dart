part of '../register_screen.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({required this.state});

  final AuthState state;

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
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

  void _submit() {
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
    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (widget.state is AuthError) ...[
            _ErrorBanner(message: (widget.state as AuthError).message),
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
              prefixIcon: const Icon(Icons.person_outline),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return l10n.validationNameRequired;
              }
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
              prefixIcon: const Icon(Icons.email_outlined),
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
              helperText: l10n.passwordRequirementsHint,
              helperMaxLines: 2,
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
              if (v == null || v.isEmpty) {
                return l10n.validationConfirmPasswordRequired;
              }
              if (v != _passwordController.text) {
                return l10n.validationPasswordsDoNotMatch;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton.primary(
            label: l10n.authCreateAccount,
            isLoading: widget.state is AuthLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
