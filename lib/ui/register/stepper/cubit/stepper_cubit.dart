import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  StepperCubit(this.stepperLength) : super(const StepperState());
  final int stepperLength;

  void stepTapped(int tappedIndex) => emit(StepperState(currentStep: tappedIndex));

  void stepContinued() {
    if(state.currentStep < stepperLength - 1) {
      emit(StepperState(currentStep: state.currentStep + 1));
    } else {
      emit(StepperState(currentStep: state.currentStep));
    }
  }

  void stepCancelled() {
    if (state.currentStep > 0) {
      emit(StepperState(currentStep: state.currentStep - 1));
    } else {
      emit(StepperState(currentStep: state.currentStep));
    }
  }
}
