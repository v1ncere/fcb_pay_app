part of 'payment_stepper_cubit.dart';

class PaymentStepperState extends Equatable {
  const PaymentStepperState({
    this.currentStep = 0,
  });
  final int currentStep;

  PaymentStepperState copyWith({
    int? currentStep,
  }) {
    return PaymentStepperState(
      currentStep: currentStep ?? this.currentStep
    );
  }

  @override
  List<Object> get props => [currentStep];
}
