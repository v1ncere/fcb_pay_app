part of 'account_add_bloc.dart';

class AccountAddState extends Equatable with FormzMixin {
  const AccountAddState({
    this.accountNumber = const AccountNumber.pure(),
    this.name = const Name.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.message = ''
  });

  final AccountNumber accountNumber;
  final Name name;
  final FormzSubmissionStatus formStatus;
  final String message;

  AccountAddState copyWith({
    AccountNumber? accountNumber,
    Name? name,
    FormzSubmissionStatus? formStatus,
    String? message
  }) {
    return AccountAddState(
      accountNumber: accountNumber ?? this.accountNumber,
      name: name ?? this.name,
      formStatus: formStatus ?? this.formStatus,
      message: message ?? this.message
    );
  }

  @override
  List<Object> get props => [accountNumber, name, formStatus, message, isValid];
  
  @override
  List<FormzInput> get inputs => [accountNumber, name];
}
