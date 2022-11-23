import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AccountModel extends Equatable{
  const AccountModel({
    required this.userId,
    this.account,
    this.balance,
    this.walletBalance,
  });

  final String userId;
  final int? account;
  final int? balance;
  final int? walletBalance;

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'account': account,
      'balance': balance,
      'wallet_balance': walletBalance,
    };
  }

  static AccountModel fromSnapshot(DocumentSnapshot snapshot) {
    AccountModel accountModel = AccountModel(
      userId: snapshot['user_id'],
      account: snapshot['account'],
      balance: snapshot['balance'],
      walletBalance: snapshot['wallet_balance'],
    );
    return accountModel;
  }

  static const empty = AccountModel(userId: '');
  bool get isEmpty => this == AccountModel.empty;
  bool get isNotEmpty => this != AccountModel.empty;
  
  @override
  List<Object?> get props => [
    userId,
    account,
    balance,
    walletBalance,
  ];
}
