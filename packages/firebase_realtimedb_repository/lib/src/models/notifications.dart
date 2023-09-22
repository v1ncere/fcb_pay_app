import 'package:firebase_database/firebase_database.dart';

class Notification {
  const Notification({
    this.keyId,
    required this.content,
    required this.isRead,
    required this.senderName,
    required this.timeStamp
  });
  final String? keyId;
  final String content;
  final bool isRead;
  final String senderName;
  final DateTime timeStamp;

  Notification copyWith({
    String? keyId,
    String? content,
    bool? isRead,
    String? senderName,
    DateTime? timeStamp,
  }) {
    return Notification(
      keyId: keyId ?? this.keyId,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      senderName: senderName ?? this.senderName,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  factory Notification.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;

    final intTimestamp = data?['time_stamp'] as int?;
    final timestamp = intTimestamp != null && intTimestamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimestamp)
    : null;
    
    return Notification(
      keyId: snapshot.key, // already has value in it
      content: data?['content'] as String? ?? '',
      isRead: data?['is_read'] as bool? ?? false,
      senderName: data?['sender_name'] as String? ?? '',
      timeStamp: timestamp ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['is_read'] = isRead;
    data['sender_name'] = senderName;
    data['time_stamp'] = timeStamp.millisecondsSinceEpoch;
    return data;
  }
}