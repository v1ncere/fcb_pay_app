part of 'fund_transfer_accounts_bloc.dart';

enum FundTransferAccountStatus { initial, loading, success, error }

class FundTransferAccountState extends Equatable {
  const FundTransferAccountState({
    this.status = Status.initial,
    this.transferAccount = const <FundTransferAccount>[],
    this.error = ""
  });
  final List<FundTransferAccount> transferAccount;
  final Status status;
  final String error;

  FundTransferAccountState copyWith({
    List<FundTransferAccount>? transferAccount,
    Status? status,
    String? error
  }) {
    return FundTransferAccountState(
      transferAccount: transferAccount ?? this.transferAccount,
      status: status ?? this.status,
      error: error ?? this.error
    );
  }

  @override
  List<Object> get props => [transferAccount, status, error];
}