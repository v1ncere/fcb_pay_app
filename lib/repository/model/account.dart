import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModel {
  final int account;
  final int balance;
  final int walletBalance;
  const AccountModel({
    required this.account,
    required this.balance,
    required this.walletBalance,
  });

  Map<String, dynamic> toMap() {
    return {
      'account': account,
      'balance': balance,
      'wallet_balance': walletBalance,
    };
  }

  AccountModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
    : account = doc.data()!['account'],
      balance = doc.data()!['balance'],
      walletBalance = doc.data()!['wallet_balance'];
}
