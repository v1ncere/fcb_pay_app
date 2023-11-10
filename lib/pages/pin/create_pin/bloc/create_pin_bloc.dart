import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_pin_repository/hive_pin_repository.dart';

part 'create_pin_event.dart';
part 'create_pin_state.dart';

class CreatePinBloc extends Bloc<CreatePinEvent, CreatePinState> {
  CreatePinBloc({
    required HivePinRepository hivePinRepository
  })  : _hivePinRepository = hivePinRepository,
  super(const CreatePinState(pinStatus: PinStatus.enterFirst)) {
    on<CreatePinAdded>(_onCreatePinAdded);
    on<CreatePinErased>(_onCreatePinErased);
    on<CreatePinNulled>(_onCreatePinNulled);
  }
  final HivePinRepository _hivePinRepository;

  void _onCreatePinAdded(CreatePinAdded event, Emitter<CreatePinState> emit) async {
    if (state.firstPin.length < 6) {
      String firstPIN = "${state.firstPin}${event.pinNum}";
      if (firstPIN.length < 6) {
        emit(state.copyWith(firstPin: firstPIN, pinStatus: PinStatus.enterFirst));
      } else {
        emit(state.copyWith(firstPin: firstPIN, pinStatus: PinStatus.enterSecond));
      }
    } else {
      String secondPIN = "${state.secondPin}${event.pinNum}";
      if (secondPIN.length < 6) {
        emit(state.copyWith(secondPin: secondPIN, pinStatus: PinStatus.enterSecond));
      } else if (secondPIN == state.firstPin) {
        _hivePinRepository.addPin(secondPIN);
        emit(state.copyWith(secondPin: secondPIN, pinStatus: PinStatus.equals));

        await Future.delayed(const Duration(seconds: 1), () => add(CreatePinNulled()));
      } else {
        emit(state.copyWith(secondPin: secondPIN, pinStatus: PinStatus.unequals));   
        
        await Future.delayed(
          const Duration(seconds: 1),
          () => emit(state.copyWith(secondPin: '', pinStatus: PinStatus.enterSecond))
        );
      }
    }
  }

  void _onCreatePinErased(CreatePinErased event, Emitter<CreatePinState> emit) {
    if (state.firstPin.isEmpty) {
      emit(state.copyWith(pinStatus: PinStatus.enterFirst));
    } else if (state.firstPin.length < 6) {
      String firstPIN = state.firstPin.substring(0, state.firstPin.length - 1);
      emit(state.copyWith(firstPin: firstPIN, pinStatus: PinStatus.enterFirst));
    } else if (state.secondPin.isEmpty) {
      add(CreatePinNulled());
    } else {
      String secondPIN = state.secondPin.substring(0, state.secondPin.length - 1);
      emit(state.copyWith(secondPin: secondPIN, pinStatus: PinStatus.enterSecond));
    }
  }

  void _onCreatePinNulled(CreatePinNulled event, Emitter<CreatePinState> emit) {
    emit(state.copyWith(firstPin: '', secondPin: '', pinStatus: PinStatus.enterFirst));
  }

  @override
  Future<void> close() {
    _hivePinRepository.close();
    return super.close();
  }
}