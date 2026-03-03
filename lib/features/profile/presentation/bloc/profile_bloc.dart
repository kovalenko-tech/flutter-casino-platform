import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/profile/domain/entities/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

/// Loads the current player's profile and handles logout.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository _authRepository;

  ProfileBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoad);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onLoad(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _authRepository.getCurrentUser();
    if (result.isRight && result.rightValue != null) {
      emit(ProfileLoaded(Profile.fromUser(result.rightValue!)));
    } else {
      emit(const ProfileError('Could not load profile.'));
    }
  }

  Future<void> _onLogout(
    LogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    await _authRepository.deleteAll();
    emit(ProfileLoggedOut());
  }
}
