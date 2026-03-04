import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_casino_platform/core/theme/app_icon_size.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/core/theme/theme_context_extension.dart';
import 'package:flutter_casino_platform/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_casino_platform/features/games/presentation/screens/games_screen.dart';
import 'package:flutter_casino_platform/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';

part 'widgets/nav_item.dart';
part 'widgets/tab_item.dart';

// Re-export tab widgets so go_router can import them from this file.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) => const HomeScreen();
}

class GamesTab extends StatelessWidget {
  const GamesTab({super.key});

  @override
  Widget build(BuildContext context) => const GamesScreen();
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) => const ProfileScreen();
}

// ── Shell ─────────────────────────────────────────────────────────────────────

/// Wraps the [StatefulNavigationShell] with the app's bottom navigation bar.
///
/// The active tab item shows in primary (gold) with a top-border accent.
/// Inactive items use the secondary text colour.
class MainShell extends StatelessWidget {
  final StatefulNavigationShell shell;

  const MainShell({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    final tabs = [
      _TabItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: l10n.navHome,
      ),
      _TabItem(
        icon: Icons.casino_outlined,
        activeIcon: Icons.casino_rounded,
        label: l10n.navCasino,
      ),
      _TabItem(
        icon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: l10n.navProfile,
      ),
    ];
    final appColors = context.appColors;
    final bgColor = appColors.background;
    final borderColor = appColors.border;

    return Scaffold(
      body: shell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              children: List.generate(tabs.length, (i) {
                final tab = tabs[i];
                final isActive = shell.currentIndex == i;

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => shell.goBranch(i),
                    child: _NavItem(
                      tab: tab,
                      isActive: isActive,
                      colors: colors,
                      textSecondary: appColors.textSecondary,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
