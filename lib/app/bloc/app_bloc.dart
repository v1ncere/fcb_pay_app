import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required FirebaseAuthRepository firebaseAuthRepository
  })  : _firebaseAuthRepository = firebaseAuthRepository, 
  super(
    firebaseAuthRepository.currentUser.isNotEmpty &&
    firebaseAuthRepository.currentUser.isVerified == true
    ? AppState.authenticated(firebaseAuthRepository.currentUser)
    : const AppState.unauthenticated()
  ) {
    on<AppUserChanged>((event, emit) {
      emit(
        event.user.isNotEmpty && event.user.isVerified == true
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated()
      );
    });

    on<AppLogoutRequested>((event, emit) {
      unawaited(_firebaseAuthRepository.logOut());
    });
    
    on<AccountArgumentPassed>((event, emit) {
      emit(AppState.accounts(event.args));
    });


    on<NotificationIdPassed>((event, emit) {
      emit(AppState.notificationViewer(event.args));
    });

    on<DynamicIdPassed>((event, emit) {
      emit(AppState.dynamicPageViewer(event.args));
    });
    
    _streamSubscription = _firebaseAuthRepository
    .user
    .listen((user) => add(AppUserChanged(user)));
  }
  final FirebaseAuthRepository _firebaseAuthRepository;
  late final StreamSubscription<User> _streamSubscription;

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
