part of 'stepper_cubit.dart';

class StepperState extends Equatable {
  const StepperState({
    this.currentStep = 0,
  });
  final int currentStep;

  StepperState copyWith({
    int? currentStep,
  }) {
    return StepperState(
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object> get props => [currentStep];
}

