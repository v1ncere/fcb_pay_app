import 'package:firebase_database/firebase_database.dart';

class TransactionFilter {
  TransactionFilter({
    required this.filter,
    required this.timeStamp
  });
  final String filter;
  final DateTime timeStamp;

  TransactionFilter copyWith({
    String? filter,
    DateTime? timeStamp
  }) {
    return TransactionFilter(
      filter: filter ?? this.filter,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  factory TransactionFilter.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimeStamp = data?['time_stamp'] as int?;
    final timeStamp = intTimeStamp != null && intTimeStamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimeStamp)
    : null;
    
    return TransactionFilter(
      filter: data?['filter'] as String? ?? '',
      timeStamp: timeStamp ?? DateTime.now(),
    );
  }
}