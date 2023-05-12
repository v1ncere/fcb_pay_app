part of 'payment_selection_dropdown_bloc.dart';

abstract class PaymentSelectionDropdownEvent extends Equatable {
  const PaymentSelectionDropdownEvent();

  @override
  List<Object> get props => [];
}

class PaymentInstitutionLoaded extends PaymentSelectionDropdownEvent {}

class PaymentInstitutionUpdated extends PaymentSelectionDropdownEvent {
  const PaymentInstitutionUpdated(this.institution);
  final List<Institution> institution;

  @override
  List<Object> get props => [institution];
}
