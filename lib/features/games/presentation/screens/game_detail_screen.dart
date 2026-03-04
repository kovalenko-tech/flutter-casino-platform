import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';
import 'package:flutter_casino_platform/core/theme/app_colors.dart';
import 'package:flutter_casino_platform/core/theme/app_icon_size.dart';
import 'package:flutter_casino_platform/core/theme/app_radius.dart';
import 'package:flutter_casino_platform/core/theme/app_spacing.dart';
import 'package:flutter_casino_platform/core/theme/app_typography.dart';
import 'package:flutter_casino_platform/core/theme/theme_context_extension.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/games/presentation/bloc/game_detail_bloc.dart';
import 'package:flutter_casino_platform/shared/extensions/volatility_l10n.dart';
import 'package:flutter_casino_platform/shared/widgets/app_button.dart';
import 'package:flutter_casino_platform/shared/widgets/category_badge.dart';
import 'package:flutter_casino_platform/shared/widgets/shimmer_image.dart';
import 'package:flutter_casino_platform/shared/widgets/shimmer_loader.dart';

part 'widgets/loading_view.dart';
part 'widgets/content_view.dart';
part 'widgets/stats_row.dart';
part 'widgets/error_view.dart';

class GameDetailScreen extends StatelessWidget {
  final String gameId;

  const GameDetailScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GameDetailBloc>()..add(LoadGameDetail(gameId)),
      child: const _GameDetailView(),
    );
  }
}

class _GameDetailView extends StatelessWidget {
  const _GameDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameDetailBloc, GameDetailState>(
        builder: (context, state) {
          return switch (state) {
            GameDetailLoading() => const _LoadingView(),
            GameDetailLoaded(:final game) => _ContentView(game: game),
            GameDetailError(:final message) => _ErrorView(message: message),
          };
        },
      ),
    );
  }
}
