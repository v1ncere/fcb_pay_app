import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_pin_repository/hive_pin_repository.dart';

part 'auth_pin_event.dart';
part 'auth_pin_state.dart';

class AuthPinBloc extends Bloc<AuthPinEvent, AuthPinState> {
  AuthPinBloc({
    required  HivePinRepository hivePinRepository,
  }): _hivePinRepository = hivePinRepository,
  super( const AuthPinState(pinStatus: AuthPinStatus.enterPin)) {
    on<AuthPinAdded>(_onAddPin);
    on<AuthPinErased>(_onErasePin);
    on<AuthPinNulled>(_onNullPin);
  }
  final HivePinRepository _hivePinRepository;

  void _onAddPin(AuthPinAdded event, Emitter<AuthPinState> emit) async {
    String pin = "${state.pin}${event.pinNum}";
    if(pin.length < 6) {
      emit(state.copyWith(pin: pin, pinStatus: AuthPinStatus.enterPin));
    } else if (await _hivePinRepository.pinEquals(pin)) {
      emit(state.copyWith(pin: pin, pinStatus: AuthPinStatus.equals));
    } else {
      emit(state.copyWith(pin: pin, pinStatus: AuthPinStatus.unequals));
      
      await Future.delayed(const Duration(seconds: 1), () => add(AuthPinNulled()));
    }
  }

  void _onErasePin(AuthPinErased event, Emitter<AuthPinState> emit) {
    if(state.pin.isEmpty) {
      emit(state.copyWith(pinStatus: AuthPinStatus.enterPin));
    } else {
      String pin = state.pin.substring(0, state.pin.length - 1); // remove the last part

      emit(state.copyWith(pin: pin, pinStatus: AuthPinStatus.enterPin));
    }
  }

  void _onNullPin(AuthPinNulled event, Emitter<AuthPinState> emit) {
    emit(state.copyWith(pin: '', pinStatus: AuthPinStatus.enterPin));
  }
}
