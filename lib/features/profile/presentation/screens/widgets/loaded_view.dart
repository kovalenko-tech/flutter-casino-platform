part of '../profile_screen.dart';

class _LoadedView extends StatelessWidget {
  final Profile profile;

  const _LoadedView({required this.profile});

  String _formatDate(DateTime date) => '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    final textSecondary = context.appColors.textSecondary;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Text(
            l10n.profileSettings,
            style: AppTypography.titleLarge(colors.onSurface),
          ),
          const SizedBox(height: AppSpacing.sm),
          _SettingsList(colors: colors, textSecondary: textSecondary),
          const SizedBox(height: AppSpacing.xl),
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
}
