import 'package:firebase_database/firebase_database.dart';

class TransactionHistory {
  String? keyId;
  final String accountId;
  final DateTime timeStamp;
  final String transactionDetails;
  final String transactionType;

  TransactionHistory({
    this.keyId,
    required this.accountId,
    required this.timeStamp,
    required this.transactionDetails,
    required this.transactionType
  });

  TransactionHistory copyWith({
    String? keyId,
    String? accountId,
    DateTime? timeStamp,
    String? transactionDetails,
    String? transactionType
  }) {
    return TransactionHistory(
      keyId: keyId ?? this.keyId,
      accountId: accountId ?? this.accountId,
      timeStamp: timeStamp ?? this.timeStamp,
      transactionDetails: transactionDetails ?? this.transactionDetails,
      transactionType: transactionType ?? this.transactionType
    );
  }

  factory TransactionHistory.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimeStamp = data?['time_stamp'] as int?;
    final timeStamp = intTimeStamp != null && intTimeStamp.abs() <= 8640000000000000
      ? DateTime.fromMillisecondsSinceEpoch(intTimeStamp)
      : null;
    
    return TransactionHistory(
      keyId: snapshot.key,
      accountId: data?['account_id'] as String? ?? '',
      transactionDetails: data?['transaction_details'] as String? ?? '',
      transactionType: data?['transaction_type'] as String? ?? '',
      timeStamp: timeStamp ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["account_id"] = accountId;
    data["transaction_details"] = transactionDetails;
    data["time_stamp"] = timeStamp;
    data["transaction_type"] = transactionType;
    return data;
  }
}