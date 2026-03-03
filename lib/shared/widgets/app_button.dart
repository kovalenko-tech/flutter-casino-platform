import 'package:flutter/material.dart';

import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';

enum _ButtonVariant { primary, secondary, ghost }

/// Opinionated button with three visual variants.
///
/// Usage:
/// ```dart
/// AppButton.primary(label: 'Play Now', onPressed: () {})
/// AppButton.secondary(label: 'Cancel', onPressed: () {})
/// AppButton.ghost(label: 'Skip', onPressed: () {})
/// ```
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? prefixIcon;
  final _ButtonVariant _variant;

  const AppButton._({
    required this.label,
    required _ButtonVariant variant,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.prefixIcon,
    super.key,
  }) : _variant = variant;

  factory AppButton.primary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    IconData? prefixIcon,
  }) =>
      AppButton._(
        key: key,
        label: label,
        variant: _ButtonVariant.primary,
        onPressed: onPressed,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        prefixIcon: prefixIcon,
      );

  factory AppButton.secondary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    IconData? prefixIcon,
  }) =>
      AppButton._(
        key: key,
        label: label,
        variant: _ButtonVariant.secondary,
        onPressed: onPressed,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        prefixIcon: prefixIcon,
      );

  factory AppButton.ghost({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isFullWidth = false,
    IconData? prefixIcon,
  }) =>
      AppButton._(
        key: key,
        label: label,
        variant: _ButtonVariant.ghost,
        onPressed: onPressed,
        isFullWidth: isFullWidth,
        prefixIcon: prefixIcon,
      );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final child = _buildChild(colors);

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 52,
      child: switch (_variant) {
        _ButtonVariant.primary => ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.mdAll,
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            ),
            child: child,
          ),
        _ButtonVariant.secondary => OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.primary,
              side: BorderSide(color: colors.primary),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.mdAll,
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            ),
            child: child,
          ),
        _ButtonVariant.ghost => TextButton(
            onPressed: isLoading ? null : onPressed,
            style: TextButton.styleFrom(
              foregroundColor: colors.primary,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            ),
            child: child,
          ),
      },
    );
  }

  Widget _buildChild(ColorScheme colors) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: _variant == _ButtonVariant.primary
              ? colors.onPrimary
              : colors.primary,
        ),
      );
    }

    if (prefixIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(prefixIcon, size: 18),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelLarge(
              _variant == _ButtonVariant.primary
                  ? colors.onPrimary
                  : colors.primary,
            ),
          ),
        ],
      );
    }

    return Text(
      label,
      style: AppTypography.labelLarge(
        _variant == _ButtonVariant.primary ? colors.onPrimary : colors.primary,
      ),
    );
  }
}
