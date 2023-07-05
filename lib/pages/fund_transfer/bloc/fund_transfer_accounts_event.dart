part of 'fund_transfer_accounts_bloc.dart';

abstract class FundTransferAccountEvent extends Equatable {
  const FundTransferAccountEvent();

  @override
  List<Object> get props => [];
}

class FundTransferAccountLoaded extends FundTransferAccountEvent {}

class FundTransferAccountUpdated extends FundTransferAccountEvent {
  const FundTransferAccountUpdated(this.account);
  final List<FundTransferAccount> account;

  @override
  List<Object> get props => [account];
}


