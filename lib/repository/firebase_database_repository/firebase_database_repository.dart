import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:fcb_pay_app/repository/repository.dart';

abstract class BaseFirebaseDatabaseRepository {
  Future<DisplayModel?> getDisplay();
  Future<void> deleteDisplay();

  Future<ReplyModel?> getReply();
  Future<String?> deleteReply();
}

class FirebaseDatabaseRepository extends BaseFirebaseDatabaseRepository {
  FirebaseDatabaseRepository({FirebaseDatabase? firebaseDatabase})
    : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;
  final FirebaseDatabase _firebaseDatabase;

  @override
  Future<DisplayModel?> getDisplay() async {
    var snapshot = await _firebaseDatabase.ref("display").child(getCurrentUserId()).get();

    if (snapshot.value != null) {
      DisplayModel display = DisplayModel.fromSnapshot(snapshot);
      return display;
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteDisplay() async {
    await _firebaseDatabase.ref("display").child(getCurrentUserId()).remove();
  }

  @override
  Future<ReplyModel?> getReply() async {
    try {
      final snapshot = await _firebaseDatabase.ref("reply").orderByChild("owner_id").equalTo(getCurrentUserId()).get();
      if (snapshot.exists) {
        ReplyModel reply = ReplyModel.fromDataSnapshot(snapshot);
        return reply;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> deleteReply() async {
    final parentNodeRef = _firebaseDatabase.ref("reply");
    final valueQuery = parentNodeRef.orderByChild("owner_id").equalTo(getCurrentUserId());

    try {
      final event = await valueQuery.once();
      final snapshot = event.snapshot;
      
      if (snapshot.value != null) {
        final values = snapshot.value as Map<dynamic, dynamic>;
        final childNodeKey = values.keys.first;
        final childNodeRef = parentNodeRef.child(childNodeKey);

        await childNodeRef.remove();
        return 'Child node removed successfully!';
      } else {
        return null;
      }
    } catch (error) {
      return 'Error removing child node: $error';
    }
  }

  String getCurrentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}