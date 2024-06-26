import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_pin_repository/hive_pin_repository.dart';

part 'create_pin_event.dart';
part 'create_pin_state.dart';

class CreatePinBloc extends Bloc<CreatePinEvent, CreatePinState> {
  CreatePinBloc({
    required HivePinRepository hivePinRepository
  })  : _hivePinRepository = hivePinRepository,
  super(const CreatePinState(status: PinStatus.enterNew)) {
    on<CreatePinAdded>(_onCreatePinAdded);
    on<CreatePinErased>(_onCreatePinErased);
    on<CreatePinNulled>(_onCreatePinNulled);
  }
  final HivePinRepository _hivePinRepository;

  void _onCreatePinAdded(CreatePinAdded event, Emitter<CreatePinState> emit) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      // Check if the length of the first PIN is less than 6 characters
      if (state.newPin.length < 6) {
        // Concatenate the entered PIN digit to the current firstPin
        final newPin = '${state.newPin}${event.pin}';
        // Check if the length of the combined firstPin is less than 6
        if (newPin.length < 6) {
          // Update the state with the new firstPin and set the pinStatus to "enterFirst"
          emit(state.copyWith(status: PinStatus.enterNew, newPin: newPin));
        } else {
          // Update the state with the new firstPin and set the pinStatus to "enterSecond"
          emit(state.copyWith(status: PinStatus.enterConfirm, newPin: newPin));
        }
      } else {
        // Concatenate the entered PIN digit to the current secondPin
        final confirmPin = '${state.confirmedPin}${event.pin}';
        // Check if the length of the combined secondPin is less than 6
        if (confirmPin.length < 6) {
          // Update the state with the new secondPin and set the pinStatus to "enterSecond"
          emit(state.copyWith(status: PinStatus.enterConfirm, confirmedPin: confirmPin));
        } else if (confirmPin == state.newPin) {
          // If secondPin matches firstPin, add the PIN to the repository, set pinStatus to "equals"
          _hivePinRepository.addPinAuth(uid: uid, pin: confirmPin);
          emit(state.copyWith(status: PinStatus.equals, confirmedPin: confirmPin));
          // Delay for 1 second and then add CreatePinNulled event
          await Future.delayed(Duration.zero, () => add(CreatePinNulled()));
        } else {
          // If secondPin does not match firstPin, set pinStatus to "unequals"
          emit(state.copyWith(status: PinStatus.unequals, confirmedPin: confirmPin));
          // Delay for 1 second and then clear the secondPin and set pinStatus to "enterSecond"
          await Future.delayed(
            Duration.zero,
            () => emit(state.copyWith(status: PinStatus.enterConfirm, confirmedPin: ''))
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onCreatePinErased(CreatePinErased event, Emitter<CreatePinState> emit) {
    // Check if the firstPin is empty
    if (state.newPin.isEmpty) {
      // Update the state with the pinStatus set to "enterFirst"
      emit(state.copyWith(status: PinStatus.enterNew));
    } else if (state.newPin.length < 6) {
      // Remove the last character from firstPin
      final newPin = state.newPin.substring(0, state.newPin.length - 1);
      // Update the state with the new firstPin and the pinStatus set to "enterFirst"
      emit(state.copyWith(newPin: newPin, status: PinStatus.enterNew));
    } else if (state.confirmedPin.isEmpty) {
      // Add the CreatePinNulled event
      add(CreatePinNulled());
    } else {
      // Remove the last character from secondPin
      final confirmPin = state.confirmedPin.substring(0, state.confirmedPin.length - 1);
      // Update the state with the new secondPin and the pinStatus set to "enterSecond"
      emit(state.copyWith(confirmedPin: confirmPin, status: PinStatus.enterConfirm));
    }
  }

  void _onCreatePinNulled(CreatePinNulled event, Emitter<CreatePinState> emit) {
    // Reset the firstPin, secondPin, and set the pinStatus to "enterFirst" in the state
    emit(state.copyWith(newPin: '', confirmedPin: '', status: PinStatus.enterNew));
  }

  @override
  Future<void> close() async {
    _hivePinRepository.closePinAuthBox();
    return super.close();
  }
}