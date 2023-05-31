import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';
  // super(firebaseAuthRepository.currentUser.isNotEmpty
  //   ? AppState.authenticated(firebaseAuthRepository.currentUser)
  //   : const AppState.unauthenticated()
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required FirebaseAuthRepository firebaseAuthRepository,
  }) : _firebaseAuthRepository = firebaseAuthRepository,
  super(const AppState.splash()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppStatusTransitioned>(_onStatusTransition);
    
    _streamSubscription = _firebaseAuthRepository.user.listen( // listening to user change
      (user) => add(AppUserChanged(user))
    );
  }
  final FirebaseAuthRepository _firebaseAuthRepository;
  StreamSubscription<User>? _streamSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(event.user.isNotEmpty
      ? AppState.authenticated(event.user)
      : const AppState.unauthenticated()
    );
  }

  void _onStatusTransition(AppStatusTransitioned event, Emitter<AppState> emit) async {
    emit(const AppState.unauthenticated());
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_firebaseAuthRepository.logOut());
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
