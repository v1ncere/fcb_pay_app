import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  StepperCubit({
    required this.stepperLength
  }) : super(const StepperState());
  final int stepperLength;

  void stepTapped(int tappedIndex) {
    emit(state.copyWith(currentStep: tappedIndex));
  }

  void stepContinued() {
    if(state.currentStep < stepperLength - 1) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    } else {
      emit(state.copyWith(currentStep: state.currentStep));
    }
  }

  void stepCancelled() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    } else {
      emit(state.copyWith(currentStep: state.currentStep));
    }
  }
}
