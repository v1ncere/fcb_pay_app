import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required FirebaseAuthRepository firebaseAuthRepository,
  }): _firebaseAuthRepository = firebaseAuthRepository, 
  super(
    firebaseAuthRepository.currentUser.isNotEmpty
      ? AppState.authenticated(firebaseAuthRepository.currentUser)
      : const AppState.unauthenticated(),
  ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _streamSubscription = _firebaseAuthRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }
  final FirebaseAuthRepository _firebaseAuthRepository;
  late final StreamSubscription<User> _streamSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_firebaseAuthRepository.logOut());
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
