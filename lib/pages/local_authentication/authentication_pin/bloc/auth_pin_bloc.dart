import 'package:equatable/equatable.dart';
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
    on<AuthPinChecked>(_onAuthPinChecked);
    on<AuthPinDelete>(_onAuthPinDelete);
  }
  final HivePinRepository _hivePinRepository;

  void _onAuthPinAdded(AuthPinAdded event, Emitter<AuthPinState> emit) async {
    String pin = "${state.pin}${event.pinNum}";
    if(pin.length < 6) {
      emit(state.copyWith(status: AuthPinStatus.enterPin, pin: pin));
    } else if (await _hivePinRepository.pinEquals(pin)) {
      emit(state.copyWith(status: AuthPinStatus.equals, pin: pin));
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

  Future<void> _onAuthPinChecked(AuthPinChecked event, Emitter<AuthPinState> emit) async {
    bool isExist = await _hivePinRepository.pinExists();
    emit(state.copyWith(isPinExist: isExist));
  }

  void _onAuthPinDelete(AuthPinDelete event, Emitter<AuthPinState> emit) async {
    await _hivePinRepository.deletePin();
    add(AuthPinChecked());
  }

  @override
  Future<void> close() {
    _hivePinRepository.closePinBox();
    return super.close();
  }
}
