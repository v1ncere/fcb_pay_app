import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_stepper_state.dart';

class PaymentStepperCubit extends Cubit<PaymentStepperState> {
  PaymentStepperCubit({
    required this.stepLength
  }) : super(const PaymentStepperState());
  final int stepLength;

  void stepTapped(int index) {
    emit(state.copyWith(currentStep: index));
  }

  void stepContinued() {
    if (state.currentStep < stepLength - 1) {
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
