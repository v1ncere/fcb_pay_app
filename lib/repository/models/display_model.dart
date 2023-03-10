import 'package:firebase_database/firebase_database.dart';

class DisplayModel {
  final String html;
  final String owner;

  const DisplayModel({
    required this.html,
    required this.owner,
  });

  DisplayModel copyWith({
    String? html,
    String? owner,
  }) {
    return DisplayModel(
      html: html ?? this.html,
      owner: owner ?? this.owner,
    );
  }

  // Convert Firebase snapshot to Display object
  DisplayModel.fromSnapshot(DataSnapshot snapshot)
    : html = (snapshot.value as Map?)?["html"] as String? ?? "",
      owner = (snapshot.value as Map?)?["owner"] as String? ?? "";

  // Convert Display object to Firebase JSON format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["html"] = html;
    data["owner"] = owner;
    return data;
  }
}