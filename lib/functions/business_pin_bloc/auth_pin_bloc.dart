import 'package:bloc/bloc.dart';
import 'package:fcb_pay_app/db/pin_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_pin_event.dart';
part 'auth_pin_state.dart';

class AuthPinBloc extends Bloc<AuthPinEvent, AuthPinState> {
  final PinRepository pinRepository;

  AuthPinBloc({required this.pinRepository}) : super(const AuthPinState(pinStatus: AuthPinStatus.enterPin)) {
    on<AuthPinAddEvent>((event, emit) async {
      String pin = "${state.pin}${event.pinNum}";
      if(pin.length < 4){
        emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.enterPin));
      }
      else if (await pinRepository.pinEquals(pin)){
        emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.equals));
      }
      else{
        emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.unequals));
        await Future.delayed(const Duration(seconds: 2), () => emit(const AuthPinState(pinStatus: AuthPinStatus.enterPin)));
      }
    });

    on<AuthPinEraseEvent>((event, emit) {
      String pin = state.pin.substring(0, state.pin.length - 1);
      emit(AuthPinState(pin: pin, pinStatus: AuthPinStatus.enterPin));
    });

    on<AuthNullPinEvent>((event, emit) {
      emit(const AuthPinState(pinStatus: AuthPinStatus.enterPin));
    });
  }
}