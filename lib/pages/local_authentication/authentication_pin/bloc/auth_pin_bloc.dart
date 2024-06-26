import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_pin_repository/hive_pin_repository.dart';

part 'auth_pin_event.dart';
part 'auth_pin_state.dart';

class AuthPinBloc extends Bloc<AuthPinEvent, AuthPinState> {
  AuthPinBloc({
    required  HivePinRepository hivePinRepository,
  })  : _hivePinRepository = hivePinRepository,
  super(const AuthPinState(status: AuthPinStatus.enterPin)) {
    on<AuthPinAdded>(_onAuthPinAdded);
    on<AuthPinErased>(_onAuthPinErased);
    on<AuthPinNulled>(_onAuthPinNulled);
  }
  final HivePinRepository _hivePinRepository;

  void _onAuthPinAdded(AuthPinAdded event, Emitter<AuthPinState> emit) async {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    String pin = '${state.pin}${event.pinNum}';
    if(pin.length < 6) {
      emit(state.copyWith(status: AuthPinStatus.enterPin, pin: pin));
    } else if (await _hivePinRepository.pinAuthEquals(uid: uid, pin: pin)) {
      emit(state.copyWith(status: AuthPinStatus.equals, pin: pin));
      await Future.delayed(Duration.zero, () => add(AuthPinNulled()));
    } else {
      emit(state.copyWith(status: AuthPinStatus.unequals, pin: pin));
      await Future.delayed(Duration.zero, () => add(AuthPinNulled()));
    }
  }

  void _onAuthPinErased(AuthPinErased event, Emitter<AuthPinState> emit) {
    if(state.pin.isEmpty) {
      emit(state.copyWith(status: AuthPinStatus.enterPin));
    } else {
      String pin = state.pin.substring(0, state.pin.length - 1);
      emit(state.copyWith(status: AuthPinStatus.enterPin, pin: pin));
    }
  }

  void _onAuthPinNulled(AuthPinNulled event, Emitter<AuthPinState> emit) {
    emit(state.copyWith(status: AuthPinStatus.enterPin, pin: ''));
  }

  @override
  Future<void> close() async {
    _hivePinRepository.closePinAuthBox();
    return super.close();
  }
}
