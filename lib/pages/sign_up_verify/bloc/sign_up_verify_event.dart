part of 'sign_up_verify_bloc.dart';

sealed class SignUpVerifyEvent extends Equatable {
  const SignUpVerifyEvent();

  @override
  List<Object> get props => [];
}

final class AccountTypeDropdownChanged extends SignUpVerifyEvent {
  const AccountTypeDropdownChanged(this.accountType);
  final AccountType accountType;

  @override
  List<Object> get props => [accountType];
}

final class AccountNumberChanged extends SignUpVerifyEvent {
  const AccountNumberChanged(this.account);
  final String account;

  @override
  List<Object> get props => [account];
}

final class FirstNameChanged extends SignUpVerifyEvent {
  const FirstNameChanged(this.firstName);
  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class MiddleNameChanged extends SignUpVerifyEvent {
  const MiddleNameChanged(this.middleName);
  final String middleName;

  @override
  List<Object> get props => [middleName];
}

final class LastNameChanged extends SignUpVerifyEvent {
  const LastNameChanged(this.lastName);
  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class BirthDateChanged extends SignUpVerifyEvent {
  const BirthDateChanged(this.date);
  final DateTime date;
  
  @override
  List<Object> get props => [date];
}

final class VerifyButtonSubmitted extends SignUpVerifyEvent {}

final class IsAccountExisted extends SignUpVerifyEvent {
  const IsAccountExisted(this.isExists);
  final bool isExists;

  @override
  List<Object> get props => [isExists];
}

final class AccountVerified extends SignUpVerifyEvent {}

final class AccountVerifyReplied extends SignUpVerifyEvent {
  const AccountVerifyReplied(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class AccountVerifyReplyUpdated extends SignUpVerifyEvent {
  const AccountVerifyReplyUpdated(this.accountVerify);
  final AccountVerify accountVerify;

  @override
  List<Object> get props => [accountVerify];
}