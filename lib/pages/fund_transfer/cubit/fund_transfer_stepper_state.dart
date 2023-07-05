part of 'fund_transfer_stepper_cubit.dart';

class FundTransferStepperState extends Equatable {
  const FundTransferStepperState({
    this.currentStep = 0
  });
  final int currentStep;

  FundTransferStepperState copyWith({
    int? currentStep
  }) {
    return FundTransferStepperState(
      currentStep: currentStep ?? this.currentStep
    );
  }

  @override
  List<Object> get props => [currentStep];
}

