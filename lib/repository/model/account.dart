import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AccountModel extends Equatable{
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

  static AccountModel fromSnapshot(DocumentSnapshot snapshot) {
    AccountModel accountModel = AccountModel(
      account: snapshot['account'],
      balance: snapshot['balance'],
      walletBalance: snapshot['wallet_balance'],
    );
    return accountModel;
  }
  
  @override
  List<Object?> get props => [
    account,
    balance,
    walletBalance,
  ];

  // AccountModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
  // : account = snapshot['account'],
  //   balance = snapshot['balance'],
  //   walletBalance = snapshot['wallet_balance'];

  // AccountModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
  //   : account = doc.data()!['account'],
  //     balance = doc.data()!['balance'],
  //     walletBalance = doc.data()!['wallet_balance'];
}
