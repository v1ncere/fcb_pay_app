import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required FirebaseAuthRepository firebaseAuthRepository
  })  : _firebaseAuthRepository = firebaseAuthRepository, 
  super(
    firebaseAuthRepository.currentUser.isNotEmpty && firebaseAuthRepository.currentUser.isVerified == true
    ? AppState.localPin(firebaseAuthRepository.currentUser)
    : const AppState.unauthenticated()
  ) {
    
    on<AppUserChanged>((event, emit) {
      emit(
        event.user.isNotEmpty && event.user.isVerified == true
        ? AppState.localPin(event.user)
        : const AppState.unauthenticated()
      );
    });
    
    on<AppLogoutRequested>((event, emit) {
      unawaited(_firebaseAuthRepository.logOut());
    });
    
    on<AppAccountsModelPassed>((event, emit) {
      emit(AppState.accountsDynamic(event.accountModel));
    });
    
    on<AppNotificationArgsPassed>((event, emit) {
      emit(AppState.notificationViewer(event.args));
    });
    
    on<AppDynamicButtonModelPassed>((event, emit) {
      emit(AppState.dynamicPageViewer(event.buttonModel));
    });
    
    on<AppAccountDynamicButtonModelPassed>((event, emit) {
      emit(AppState.accountDynamicPageViewer(event.buttonModel));
    });

    _streamSubscription = _firebaseAuthRepository.user.listen((user) => add(AppUserChanged(user)));
  }
  final FirebaseAuthRepository _firebaseAuthRepository;
  late final StreamSubscription<User> _streamSubscription;

  @override
  Future<void> close() async {
    _streamSubscription.cancel();
    return super.close();
  }
}
