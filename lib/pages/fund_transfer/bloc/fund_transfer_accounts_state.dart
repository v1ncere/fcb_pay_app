part of 'fund_transfer_accounts_bloc.dart';

enum FundTransferAccountStatus { initial, loading, success, error }

class FundTransferAccountState extends Equatable {
  const FundTransferAccountState({
    this.status = FundTransferAccountStatus.initial,
    this.transferAccount = const <FundTransferAccount>[],
    this.error = ""
  });
  final List<FundTransferAccount> transferAccount;
  final FundTransferAccountStatus status;
  final String error;

  FundTransferAccountState copyWith({
    List<FundTransferAccount>? transferAccount,
    FundTransferAccountStatus? status,
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

extension FundTransferAccountStatusX on FundTransferAccountStatus {
  bool get isInitial => this == FundTransferAccountStatus.initial;
  bool get isLoading => this == FundTransferAccountStatus.loading;
  bool get isSuccess => this == FundTransferAccountStatus.success;
  bool get isError => this == FundTransferAccountStatus.error;
}