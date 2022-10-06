// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class Create extends HomeEvent {
  final int account;
  final int balance;
  final int walletBalance;

  const Create({
    required this.account,
    required this.balance,
    required this.walletBalance,
  });
}

class GetData extends HomeEvent {
  const GetData();
}
