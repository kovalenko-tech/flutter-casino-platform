import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
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
import 'package:flutter_casino_platform/shared/widgets/shimmer_loader.dart';
import 'package:flutter_casino_platform/features/profile/domain/entities/profile.dart';
import 'package:flutter_casino_platform/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(const LoadProfile()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut) {
          context.go(AppConstants.routeLogin);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.profileTitle),
            actions: [
              if (state is ProfileLoaded)
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {},
                ),
            ],
          ),
          body: switch (state) {
            ProfileLoading() => const _LoadingView(),
            ProfileLoaded(:final profile) => _LoadedView(profile: profile),
            ProfileError(:final message) => _ErrorView(message: message),
            ProfileLoggedOut() => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          ShimmerLoader.card(height: 120),
          const SizedBox(height: AppSpacing.md),
          ShimmerLoader.card(height: 80),
          const SizedBox(height: AppSpacing.md),
          ShimmerLoader.card(height: 200),
        ],
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final Profile profile;

  const _LoadedView({required this.profile});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Avatar card ──────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              borderRadius: AppRadius.lgAll,
            ),
            child: Column(
              children: [
                _Avatar(initials: profile.initials, colors: colors),
                const SizedBox(height: AppSpacing.md),
                Text(
                  profile.name,
                  style: AppTypography.headlineMedium(colors.onSurface),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  profile.email,
                  style: AppTypography.bodyMedium(textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // ── Stats row ────────────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: l10n.profileMemberSince,
                  value: _formatDate(profile.memberSince),
                  icon: Icons.calendar_month_outlined,
                  colors: colors,
                  textSecondary: textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _StatCard(
                  label: l10n.profileAccountId,
                  value: profile.accountId,
                  icon: Icons.badge_outlined,
                  colors: colors,
                  textSecondary: textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Settings ─────────────────────────────────────────────────────
          Text(
            l10n.profileSettings,
            style: AppTypography.titleLarge(colors.onSurface),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingsList(colors, textSecondary, l10n),
          const SizedBox(height: AppSpacing.xl),

          // ── Logout ───────────────────────────────────────────────────────
          AppButton.secondary(
            label: l10n.profileSignOut,
            prefixIcon: Icons.logout,
            onPressed: () =>
                context.read<ProfileBloc>().add(const LogoutRequested()),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';

  Widget _buildSettingsList(
    ColorScheme colors,
    Color textSecondary,
    AppLocalizations l10n,
  ) {
    final items = [
      (Icons.notifications_outlined, l10n.profileNotifications),
      (Icons.language_outlined, l10n.profileLanguage),
      (Icons.security_outlined, l10n.profileSecurity),
    ];

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: AppRadius.lgAll,
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final (icon, label) = entry.value;
          return Column(
            children: [
              ListTile(
                leading: Icon(icon, color: colors.onSurface, size: 22),
                title: Text(
                  label,
                  style: AppTypography.bodyMedium(colors.onSurface),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: textSecondary,
                  size: 20,
                ),
                onTap: () {},
              ),
              if (i < items.length - 1)
                Divider(
                  height: 1,
                  indent: AppSpacing.lg + 22 + AppSpacing.md,
                  color: colors.outline.withOpacity(0.5),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  final ColorScheme colors;

  const _Avatar({required this.initials, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary, colors.secondary],
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(initials, style: AppTypography.headlineLarge(Colors.white)),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final ColorScheme colors;
  final Color textSecondary;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.colors,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: AppRadius.lgAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colors.primary, size: 20),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: AppTypography.labelSmall(textSecondary)),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.labelMedium(colors.onSurface),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: colors.error, size: 48),
          const SizedBox(height: AppSpacing.md),
          Text(message, style: AppTypography.bodyMedium(colors.onSurface)),
          const SizedBox(height: AppSpacing.lg),
          AppButton.secondary(
            label: l10n.retry,
            isFullWidth: false,
            onPressed: () =>
                context.read<ProfileBloc>().add(const LoadProfile()),
          ),
        ],
      ),
    );
  }
}
