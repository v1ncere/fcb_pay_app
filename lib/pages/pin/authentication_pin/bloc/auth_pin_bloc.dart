import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:fcb_pay_app/repository/repository.dart';

part 'auth_pin_event.dart';
part 'auth_pin_state.dart';

class AuthPinBloc extends Bloc<AuthPinEvent, AuthPinState> {
  final BaseHivePinService _baseHivePinService;

  AuthPinBloc({
    required  BaseHivePinService baseHivePinService,
  }) : _baseHivePinService = baseHivePinService,
      super(const AuthPinState(pinStatus: AuthPinStatus.enterPin)) {
        on<AuthPinAddEvent>(_onAddPin);
        on<AuthPinEraseEvent>(_onErasePin);
        on<AuthNullPinEvent>(_onNullPin);
      }

  void _onAddPin(AuthPinAddEvent event, Emitter<AuthPinState> emit) async {
    String pin = "${state.pin}${event.pinNum}";
    if(pin.length < 6) {
      emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.enterPin));
    } else if (await _baseHivePinService.pinEquals(pin)) {
      emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.equals));
    } else {
      emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.unequals));
      await Future.delayed(const Duration(seconds: 2), () => emit(const AuthPinState(pinStatus: AuthPinStatus.enterPin)));
    }
  }

  void _onErasePin(AuthPinEraseEvent event, Emitter<AuthPinState> emit) {
    if(state.pin.isEmpty) {
      emit(const AuthPinState(pinStatus: AuthPinStatus.enterPin));
    } else {
      String pin = state.pin.substring(0, state.pin.length - 1);
      emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.enterPin));
    }
  }

  void _onNullPin(AuthNullPinEvent event, Emitter<AuthPinState> emit) {
    emit(const AuthPinState(pinStatus: AuthPinStatus.enterPin));
  }
}