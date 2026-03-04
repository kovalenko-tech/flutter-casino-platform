part of '../home_screen.dart';

class _HomeAppBar extends StatelessWidget {
  final Color backgroundColor;

  const _HomeAppBar({required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      backgroundColor: backgroundColor,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Icon(
              Icons.casino_rounded,
              color: colors.onPrimary,
              size: AppIconSize.sm,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            l10n.homeTitle,
            style: AppTypography.titleLarge(colors.onSurface),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: colors.onSurface),
          onPressed: () => context.push(AppConstants.routeNotifications),
        ),
      ],
    );
  }
}
