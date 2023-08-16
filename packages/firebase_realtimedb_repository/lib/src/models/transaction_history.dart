import 'package:firebase_database/firebase_database.dart';

class TransactionHistory {
  TransactionHistory({
    this.keyId,
    required this.accountNumber,
    required this.accountType,
    required this.details,
    required this.timeStamp,
  });
  String? keyId;
  final String accountNumber;
  final String accountType;
  final DateTime timeStamp;
  final String details;

  TransactionHistory copyWith({
    String? keyId,
    String? accountNumber,
    String? accountType,
    String? details,
    DateTime? timeStamp
  }) {
    return TransactionHistory(
      keyId: keyId ?? this.keyId,
      accountNumber: accountNumber ?? this.accountNumber,
      accountType: accountType ?? this.accountType,
      details: details ?? this.details,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  factory TransactionHistory.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimeStamp = data?['time_stamp'] as int?;
    final timeStamp = intTimeStamp != null && intTimeStamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimeStamp)
    : null;
    
    return TransactionHistory(
      keyId: snapshot.key,
      accountNumber: data?['account_number'] as String? ?? '',
      accountType: data?['account_type'] as String? ?? '',
      details: data?['details'] as String? ?? '',
      timeStamp: timeStamp ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["account_number"] = accountNumber;
    data["account_type"] = accountType;
    data["details"] = details;
    data["time_stamp"] = timeStamp;
    return data;
  }
}