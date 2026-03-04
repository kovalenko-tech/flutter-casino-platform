import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_casino_platform/core/constants/app_constants.dart';
import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/theme/app_icon_size.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/core/theme/theme_context_extension.dart';
import 'package:flutter_casino_platform/shared/widgets/app_button.dart';
import 'package:flutter_casino_platform/shared/widgets/shimmer_loader.dart';
import 'package:flutter_casino_platform/features/profile/domain/entities/profile.dart';
import 'package:flutter_casino_platform/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';

part 'widgets/loading_view.dart';
part 'widgets/loaded_view.dart';
part 'widgets/settings_list.dart';
part 'widgets/avatar.dart';
part 'widgets/stat_card.dart';
part 'widgets/error_view.dart';

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
            actions: const [],
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
