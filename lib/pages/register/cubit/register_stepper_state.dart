part of 'register_stepper_cubit.dart';

class RegisterStepperState extends Equatable {
  const RegisterStepperState({
    this.currentStep = 0
  });
  final int currentStep;

  RegisterStepperState copyWith({
    int? currentStep
  }) {
    return RegisterStepperState(
      currentStep: currentStep ?? this.currentStep
    );
  }

  @override
  List<Object> get props => [currentStep];
}
