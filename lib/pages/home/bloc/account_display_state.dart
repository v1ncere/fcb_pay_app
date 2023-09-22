part of 'account_display_bloc.dart';

abstract class AccountDisplayState extends Equatable {
  const AccountDisplayState();
  
  @override
  List<Object> get props => [];
}

class AccountDisplayInProgress extends AccountDisplayState {}

class AccountDisplaySuccess extends AccountDisplayState {
  const AccountDisplaySuccess({this.accounts = const <Account>[]});
  final List<Account> accounts;

  @override
  List<Object> get props => [accounts];
}

class AccountDisplayError extends AccountDisplayState {
  const AccountDisplayError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
