import 'package:firebase_database/firebase_database.dart';

class FundTransferAccount {
  String? keyId;
  final String account;
  final DateTime timeStamp;

  FundTransferAccount ({
    this.keyId,
    required this.account,
    required this.timeStamp
  });

  FundTransferAccount copyWith({
    String? keyId,
    String? account,
    DateTime? timeStamp
  }) {
    return FundTransferAccount(
      keyId: keyId ?? this.keyId,
      account: account ?? this.account,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  factory FundTransferAccount.fromSnapshot(DataSnapshot dataSnapshot) {
    final data = dataSnapshot.value as Map?;
    final intTimeStamp = data?["time_stamp"] as int?;
    final timeStamp = intTimeStamp != null && intTimeStamp.abs() <= 9999999999999
      ? DateTime.fromMillisecondsSinceEpoch(intTimeStamp)
      : null;

    return FundTransferAccount(
      keyId: dataSnapshot.key,
      account: data?["account"] as String? ?? "",
      timeStamp: timeStamp ?? DateTime.now()
    );
  }
}