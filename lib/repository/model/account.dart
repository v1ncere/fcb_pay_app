import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends Equatable {
  @HiveField(0)
  final String userID;
  @HiveField(1)
  final int? account;
  @HiveField(2)
  final int? balance;
  @HiveField(3)
  final int? walletBalance;

  const Account({
    required this.userID,
    this.account,
    this.balance,
    this.walletBalance,
  });

  Account copyWith({
    String? userID,
    int? balance,
    int? account,
    int? walletBalance,
  }) {
    return Account(
      userID: userID ?? this.userID,
      balance: balance ?? this.balance,
      account: account ?? this.account,
      walletBalance: walletBalance ?? this.walletBalance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userID,
      'account': account,
      'balance': balance,
      'wallet_balance': walletBalance,
    };
  }

  static Account fromSnapshot(
    DocumentSnapshot snapshot
  ) {
    Account accountModel = Account(
      userID: snapshot['user_id'],
      account: snapshot['account'],
      balance: snapshot['balance'],
      walletBalance: snapshot['wallet_balance'],
    );
    return accountModel;
  }

  static const empty = Account(userID: "");
  bool get isEmpty => this == Account.empty;
  bool get isNotEmpty => this != Account.empty;
  
  @override
  List<Object?> get props => [
    userID,
    account,
    balance,
    walletBalance,
  ];
}
