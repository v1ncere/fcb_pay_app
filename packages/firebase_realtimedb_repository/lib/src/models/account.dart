import 'package:firebase_database/firebase_database.dart';

class Account {
  Account({
    this.keyId,
    required this.balance,
    this.creditLimit,
    required this.type,
    required this.ownerId,
    this.expiry,
    required this.timeStamp
  });

  String? keyId;
  final double balance;
  final double? creditLimit;
  final String type;
  final String ownerId;
  final DateTime? expiry;
  final DateTime timeStamp;

  Account copyWith({
    String? keyId,
    double? balance,
    double? creditLimit,
    String? type,
    String? ownerId,
    DateTime? expiry,
    DateTime? timeStamp
  }) {
    return Account(
      keyId: keyId ?? this.keyId,
      balance: balance ?? this.balance,
      creditLimit: creditLimit ?? this.creditLimit,
      type: type ?? this.type,
      ownerId: ownerId ?? this.ownerId,
      expiry: expiry ?? this.expiry,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  factory Account.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final dynamicBalance = data?['balance'];
    final dynamicCreditLimit = data?['credit_limit'];
    final intExpiry = data?['expiry'] as int?;
    final intTimeStamp = data?['time_stamp'] as int?;

    return Account(
      keyId: snapshot.key,
      balance: doubleConverter(dynamicBalance) ?? 0.0,
      creditLimit: doubleConverter(dynamicCreditLimit) ?? 0.0,
      expiry: millisConverter(intExpiry) ?? DateTime.now(),
      type: data?['type'] as String? ?? '',
      ownerId: data?['owner_id'] as String? ?? '',
      timeStamp: millisConverter(intTimeStamp) ?? DateTime.now()
    );
  }
}

DateTime? millisConverter(int? intDate) {
  if (intDate != null && intDate <= 9999999999999) {
    return DateTime.fromMillisecondsSinceEpoch(intDate);
  } else {
    return null;
  }
}

double? doubleConverter(dynamic dynamicAmount) {
  if (dynamicAmount is int) {
    return dynamicAmount.toDouble();
  } else {
    return dynamicAmount as double?;
  }
}

// class Accounts {
//   Accounts({
//     this.keyId,
//     required this.displayData,
//     required this.ownerId,
//     required this.timeStamp,
//   });

//   String? keyId;
//   final String displayData;
//   final String ownerId;
//   final DateTime timeStamp;

//   Accounts copyWith({
//     String? keyId,
//     String? displayData,
//     String? ownerId,
//     DateTime? timeStamp,
//   }) {
//     return Accounts(
//       keyId: keyId ?? this.keyId,
//       displayData: displayData ?? this.displayData,
//       ownerId: ownerId ?? this.ownerId,
//       timeStamp: timeStamp ?? this.timeStamp
//     );
//   }

//   factory Accounts.fromSnapshot(DataSnapshot snapshot) {
//     final data = snapshot.value as Map?;
//     final intTimestamp = data?['time_stamp'] as int?;
//     final timestamp = intTimestamp != null && intTimestamp.abs() <= 9999999999999
//     ? DateTime.fromMillisecondsSinceEpoch(intTimestamp)
//     : null;

//     return Accounts(
//       keyId: snapshot.key,
//       displayData: data?['display_data'] as String? ?? '',
//       ownerId: data?['owner_id'] as String? ?? '',
//       timeStamp: timestamp ?? DateTime.now(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["display_data"] = displayData;
//     data["owner_id"] = ownerId;
//     data["time_stamp"] = timeStamp;
//     return data;
//   }
// }