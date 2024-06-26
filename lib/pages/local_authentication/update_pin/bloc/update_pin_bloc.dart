import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';

part 'update_pin_event.dart';
part 'update_pin_state.dart';

class UpdatePinBloc extends Bloc<UpdatePinEvent, UpdatePinState> {
  UpdatePinBloc({
    required HivePinRepository hiveRepository
  }) : _hiveRepository = hiveRepository,
  super(const UpdatePinState(status: UpdatePinStatus.enterCurrent)) {
    on<UpdatePinAdded>(_onChangePinAdded);
    on<UpdatePinErased>(_onChangePinErased);
    on<UpdatePinNulled>(_onChangePinNulled);
  }
  final HivePinRepository _hiveRepository;

  void _onChangePinAdded(UpdatePinAdded event, Emitter<UpdatePinState> emit) async {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final currentPin = '${state.currentPin}${event.pin}';
    if (state.status.isEnterCurrent && currentPin.length < 6) {
      emit(state.copyWith(status: UpdatePinStatus.enterCurrent, currentPin: currentPin));
    } else if (await _hiveRepository.pinAuthEquals(uid: uid, pin: currentPin)) {
      emit(state.copyWith(status: UpdatePinStatus.currentEquals, currentPin: currentPin));
      await Future.delayed(
        Duration.zero,
        () => emit(state.copyWith(status: UpdatePinStatus.enterNew, currentPin: currentPin)) 
      );
    } else if (state.status.isEnterNew && state.newPin.length < 6) {
      final newPin = '${state.newPin}${event.pin}';
      if (newPin.length < 6) {
        emit(state.copyWith(status: UpdatePinStatus.enterNew, newPin: newPin));
      } else {
        emit(state.copyWith(status: UpdatePinStatus.enterConfirm, newPin: newPin));
      }
    } else if (state.status.isEnterConfirm && state.confirmedPin.length < 6) {
      final confirmedPin = '${state.confirmedPin}${event.pin}';
      if (confirmedPin.length < 6) {
        emit(state.copyWith(status: UpdatePinStatus.enterConfirm, confirmedPin: confirmedPin));
      } else if (confirmedPin == state.newPin) {
        _hiveRepository.addPinAuth(uid: uid, pin: confirmedPin);
        emit(state.copyWith(status: UpdatePinStatus.updateEquals, confirmedPin: confirmedPin));
        await Future.delayed(Duration.zero, () => add(UpdatePinNulled()));
      } else {
        emit(state.copyWith(status: UpdatePinStatus.updateUnequals, confirmedPin: confirmedPin));
        await Future.delayed(
          Duration.zero,
          () => emit(state.copyWith(status: UpdatePinStatus.enterConfirm, confirmedPin: ''))
        );
      }
    }
    else {
      emit(state.copyWith(status: UpdatePinStatus.currentUnequals, currentPin: currentPin));
      await Future.delayed(Duration.zero, () => add(UpdatePinNulled()));
    }
  }

  void _onChangePinErased(UpdatePinErased event, Emitter<UpdatePinState> emit) {
    if(state.currentPin.isEmpty) {
      emit(state.copyWith(status: UpdatePinStatus.enterCurrent));
    } else if (state.currentPin.length < 6) {
      final auth = state.currentPin.substring(0, state.currentPin.length - 1);
      emit(state.copyWith(status: UpdatePinStatus.enterCurrent, currentPin: auth));
    } else if(state.newPin.isEmpty) {
      emit(state.copyWith(status: UpdatePinStatus.enterCurrent, currentPin: ''));
    } else if(state.newPin.length < 6) {
      final first = state.newPin.substring(0, state.newPin.length - 1);
      emit(state.copyWith(status: UpdatePinStatus.enterNew, newPin: first));
    } else if (state.confirmedPin.isEmpty) {
      emit(state.copyWith(status: UpdatePinStatus.enterNew, newPin: ''));
    } else {
      final second = state.confirmedPin.substring(0, state.confirmedPin.length - 1);
      emit(state.copyWith(status: UpdatePinStatus.enterConfirm, confirmedPin: second));
    }
  }

  void _onChangePinNulled(UpdatePinNulled event, Emitter<UpdatePinState> emit) {
    emit(state.copyWith(status: UpdatePinStatus.enterCurrent, currentPin: '', newPin: '', confirmedPin: ''));
  }

  @override
  Future<void> close() async {
    _hiveRepository.closePinAuthBox();
    return super.close();
  }
}
