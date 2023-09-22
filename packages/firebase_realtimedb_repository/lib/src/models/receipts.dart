import 'package:firebase_database/firebase_database.dart';

class Receipt {
  const Receipt({
    this.keyId,
    required this.amount,
    required this.confirm,
    required this.description,
    required this.reference,
    required this.title,
    required this.timeStamp
  });
  final String? keyId;
  final double amount;
  final bool confirm;
  final String description;
  final int reference;
  final String title;
  final DateTime timeStamp;

  Receipt copyWith({
    String? keyId,
    double? amount,
    bool? confirm,
    String? description,
    int? reference,
    String? title,
    DateTime? timeStamp
  }) {
    return Receipt(
      keyId: keyId ?? this.keyId,
      amount: amount ?? this.amount,
      confirm: confirm ?? this.confirm,
      description: description ?? this.description,
      reference: reference ?? this.reference,
      timeStamp: timeStamp ?? this.timeStamp,
      title: title ?? this.title
    );
  }

  factory Receipt.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;

    final intTimestamp = data?['time_stamp'] as int?;
    final _timeStamp = intTimestamp != null && intTimestamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimestamp)
    : null;

    final dynamicAmount = data?['amount']; // retrieve amount as dynamic
    final doubleAmount = dynamicAmount is int
    ? dynamicAmount.toDouble()
    : dynamicAmount as double?;

    return Receipt(
      keyId: snapshot.key, // has already value in it, be careful!
      amount: doubleAmount ?? 0.0,
      confirm: data?['confirm'] as bool? ?? false,
      description: data?['description'] as String? ?? '',
      reference: data?['reference'] as int? ?? 0,
      timeStamp: _timeStamp ?? DateTime.now(),
      title: data?['title'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['confirm'] = confirm;
    data['reason'] = description;
    data['reference'] = reference;
    data["time_stamp"] = timeStamp.millisecondsSinceEpoch;
    data['title'] = title;
    return data;
  }
}
