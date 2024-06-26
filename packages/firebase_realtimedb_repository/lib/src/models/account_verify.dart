import 'package:firebase_database/firebase_database.dart';

import '../utils/utils.dart';

class AccountVerify {
  const AccountVerify({
    this.keyId,
    required this.dataVerifier,
    this.timeStamp
  });
  final String? keyId;
  final String dataVerifier;
  final DateTime? timeStamp;

  AccountVerify copyWith({
    String? keyId,
    String? dataVerifier,
    DateTime? timeStamp
  }) {
    return AccountVerify(
      keyId: keyId ?? this.keyId,
      dataVerifier: dataVerifier ?? this.dataVerifier,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  static const empty = AccountVerify(dataVerifier: '');
  bool get isEmpty => this == AccountVerify.empty;
  bool get isNotEmpty => this != AccountVerify.empty;

  factory AccountVerify.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimeStamp = data?['time_stamp'] as int?;
    return AccountVerify(
      keyId: snapshot.key,
      dataVerifier: data?['data_verifier'] as String? ?? '',
      timeStamp: millisConverter(intTimeStamp) ?? DateTime.now()
    );
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_verifier'] = dataVerifier;
    data['time_stamp'] = timeStamp!.millisecondsSinceEpoch;
    return data;
  }
}