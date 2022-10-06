// ignore_for_file: must_be_immutable
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeTabInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class AccountAdding extends HomeState {
  @override
  List<Object?> get props => [];
}

class AccountAdded extends HomeState {
  @override
  List<Object?> get props => [];
}

class AccountError extends HomeState {
  final String error;
  const AccountError(this.error);
  @override
  List<Object?> get props => [];
}

class AccountLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class AccountLoaded extends HomeState {
  List<AccountModel> accountData;
  AccountLoaded(this.accountData);
  @override
  List<Object?> get props => [accountData];
}
