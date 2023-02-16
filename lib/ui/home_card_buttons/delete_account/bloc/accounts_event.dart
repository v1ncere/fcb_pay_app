part of 'accounts_bloc.dart';

abstract class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object> get props => [];
}

class AccountInitialEvent extends AccountsEvent {}

class AddAccountEvent extends AccountsEvent {
  const AddAccountEvent({
    required this.account,
  });
  final Account account;

  @override
  List<Object> get props => [account];
}

class EditAccountEvent extends AccountsEvent {
  const EditAccountEvent({
    required this.accounts
  });
  final Account accounts;

  @override
  List<Object> get props => [accounts];
}

class DeleteAccountEvent extends AccountsEvent {
  const DeleteAccountEvent({required this.account});
  final Account account;

  @override
  List<Object> get props => [account];
}