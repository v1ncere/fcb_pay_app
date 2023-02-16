import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fcb_pay_app/repository/repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository
  }): _authenticationRepository = authenticationRepository,
      super(
        authenticationRepository.currentUser.isNotEmpty
          ? AppState.authenticated(authenticationRepository.currentUser)
          : const AppState.unauthenticated(),
      ) {
        on<AppUserChanged>(_onUserChanged);
        on<AppLogoutRequested>(_onLogoutRequested);
        _userSubscription = _authenticationRepository.user.listen(
          (user) => add(AppUserChanged(user)),
        );
      }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<Account> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
