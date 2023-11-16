import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
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
    try {
      // Check if the length of the first PIN is less than 6 characters
      if (state.firstPin.length < 6) {
        // Concatenate the entered PIN digit to the current firstPin
        final firstPin = "${state.firstPin}${event.pinNum}";
        // Check if the length of the combined firstPin is less than 6
        if (firstPin.length < 6) {
          // Update the state with the new firstPin and set the pinStatus to "enterFirst"
          emit(state.copyWith(firstPin: firstPin, pinStatus: PinStatus.enterFirst));
        } else {
          // Update the state with the new firstPin and set the pinStatus to "enterSecond"
          emit(state.copyWith(firstPin: firstPin, pinStatus: PinStatus.enterSecond));
        }
      } else {
        // Concatenate the entered PIN digit to the current secondPin
        final secondPin = "${state.secondPin}${event.pinNum}";
        // Check if the length of the combined secondPin is less than 6
        if (secondPin.length < 6) {
          // Update the state with the new secondPin and set the pinStatus to "enterSecond"
          emit(state.copyWith(secondPin: secondPin, pinStatus: PinStatus.enterSecond));
        } else if (secondPin == state.firstPin) {
          // If secondPin matches firstPin, add the PIN to the repository, set pinStatus to "equals"
          _hivePinRepository.addPin(secondPin);
          emit(state.copyWith(secondPin: secondPin, pinStatus: PinStatus.equals));
          // Delay for 1 second and then add CreatePinNulled event
          await Future.delayed(Duration.zero, () => add(CreatePinNulled()));
        } else {
          // If secondPin does not match firstPin, set pinStatus to "unequals"
          emit(state.copyWith(secondPin: secondPin, pinStatus: PinStatus.unequals));
          // Delay for 1 second and then clear the secondPin and set pinStatus to "enterSecond"
          await Future.delayed(Duration.zero,
            () => emit(state.copyWith(secondPin: '', pinStatus: PinStatus.enterSecond))
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onCreatePinErased(CreatePinErased event, Emitter<CreatePinState> emit) {
    // Check if the firstPin is empty
    if (state.firstPin.isEmpty) {
      // Update the state with the pinStatus set to "enterFirst"
      emit(state.copyWith(pinStatus: PinStatus.enterFirst));
    } else if (state.firstPin.length < 6) {
      // Remove the last character from firstPin
      final firstPin = state.firstPin.substring(0, state.firstPin.length - 1);
      // Update the state with the new firstPin and the pinStatus set to "enterFirst"
      emit(state.copyWith(firstPin: firstPin, pinStatus: PinStatus.enterFirst));
    } else if (state.secondPin.isEmpty) {
      // Add the CreatePinNulled event
      add(CreatePinNulled());
    } else {
      // Remove the last character from secondPin
      final secondPin = state.secondPin.substring(0, state.secondPin.length - 1);
      // Update the state with the new secondPin and the pinStatus set to "enterSecond"
      emit(state.copyWith(secondPin: secondPin, pinStatus: PinStatus.enterSecond));
    }
  }

  void _onCreatePinNulled(CreatePinNulled event, Emitter<CreatePinState> emit) {
    // Reset the firstPin, secondPin, and set the pinStatus to "enterFirst" in the state
    emit(state.copyWith(firstPin: '', secondPin: '', pinStatus: PinStatus.enterFirst));
  }

  @override
  Future<void> close() {
    _hivePinRepository.closePinBox();
    return super.close();
  }
}