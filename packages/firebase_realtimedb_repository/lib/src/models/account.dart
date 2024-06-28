import 'package:firebase_database/firebase_database.dart';

import '../utils/utils.dart';

class Account {
  const Account({
    this.accountKeyID,
    required this.ownerName,
    this.balance,
    this.creditLimit,
    required this.type,
    required this.category,
    required this.ownerId,
    this.expiry,
    this.timeStamp
  });
  final String? accountKeyID; // "ACCOUNT NUMBER" is the node ID
  final String ownerName;
  final double? balance;
  final double? creditLimit;
  final String type;
  final String category;
  final String ownerId;
  final DateTime? expiry;
  final DateTime? timeStamp;

  Account copyWith({
    String? accountKeyID,
    String? ownerName,
    double? balance,
    double? creditLimit,
    String? type,
    String? category,
    String? ownerId,
    DateTime? expiry,
    DateTime? timeStamp
  }) {
    return Account(
      accountKeyID: accountKeyID ?? this.accountKeyID,
      ownerName: ownerName ?? this.ownerName,
      balance: balance ?? this.balance,
      creditLimit: creditLimit ?? this.creditLimit,
      type: type ?? this.type,
      category: category ?? this.category,
      ownerId: ownerId ?? this.ownerId,
      expiry: expiry ?? this.expiry,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  static const empty = Account(ownerName: '', type: '', category: '', ownerId: '');
  bool get isEmpty => this == Account.empty;
  bool get isNotEmpty => this != Account.empty;

  factory Account.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final balance = data?['balance'];
    final creditLimit = data?['credit_limit'];
    final expiry = data?['expiry'] as int?;
    final timeStamp = data?['time_stamp'] as int?;

    return Account(
      accountKeyID: snapshot.key,
      ownerName: data?['owner_name'] as String? ?? '',
      balance: doubleConverter(balance) ?? 0.0, // convert int into double
      creditLimit: doubleConverter(creditLimit) ?? 0.0, // convert int into double
      expiry: millisConverter(expiry) ?? DateTime.now(), // convert int into DateTime
      type: data?['type'] as String? ?? '',
      category: data?['category'] as String? ?? '',
      ownerId: data?['owner_id'] as String? ?? '',
      timeStamp: millisConverter(timeStamp) ?? DateTime.now() // convert int into DateTime
    );
  }
}