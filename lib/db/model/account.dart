class AccountModel {
  final int account;
  final int balance;
  final int walletBalance;

  AccountModel({
    required this.account,
    required this.balance,
    required this.walletBalance
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'account': account,
      'balance': balance,
      'wallet_balance' : walletBalance,
    };
  }

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      account: json['account'],
      balance: json['balance'],
      walletBalance: json['wallet_balance'],
    );
  }
}
