import 'package:firebase_database/firebase_database.dart';

class TransactionHistory {
  String? keyId;
  final String ownerId;
  final DateTime timeStamp;
  final String transactionDetails;

  TransactionHistory({
    this.keyId,
    required this.ownerId,
    required this.timeStamp,
    required this.transactionDetails,
  });

  TransactionHistory copyWith({
    String? keyId,
    String? ownerId,
    DateTime? timeStamp,
    String? transactionDetails
  }) {
    return TransactionHistory(
      keyId: keyId ?? this.keyId,
      ownerId: ownerId ?? this.ownerId,
      timeStamp: timeStamp ?? this.timeStamp,
      transactionDetails: transactionDetails ?? this.transactionDetails,
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
      transactionDetails: data?['transaction_details'] as String? ?? '',
      ownerId: data?['owner_id'] as String? ?? '',
      timeStamp: timeStamp ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["transaction_details"] = transactionDetails;
    data["owner_id"] = ownerId;
    data["time_stamp"] = timeStamp;
    return data;
  }
}