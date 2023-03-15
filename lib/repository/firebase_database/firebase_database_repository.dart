import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:fcb_pay_app/repository/repository.dart';

abstract class BaseFirebaseDatabaseRepository {
  Future<DisplayModel?> getDisplay();

  Future<ServerReply?> getServerReply();
  Future<String?> deleteServerReply();
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
  Future<ServerReply?> getServerReply() async {
    try {
      final snapshot = await _firebaseDatabase.ref('server_reply')
      .orderByChild('owner_id')
      .equalTo(getCurrentUserId())
      .get();
      
      if (snapshot.exists) {
        ServerReply serverReply = ServerReply.fromDataSnapshot(snapshot);
        return serverReply;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> deleteServerReply() async {
    final parentNodeRef = _firebaseDatabase.ref('server_reply');
    final valueQuery = parentNodeRef.orderByChild('owner_id').equalTo(getCurrentUserId());

    try {
      final event = await valueQuery.once();
      final snapshot = event.snapshot;
      
      if (snapshot.value != null) {
        final values = snapshot.value as Map<dynamic, dynamic>;
        final childNodeKey = values.keys.first;
        final childNodeRef = parentNodeRef.child(childNodeKey);

        await childNodeRef.remove();
        return 'Server data reply removed successfully!';
      } else {
        return null;
      }
    } catch (error) {
      return 'Error removing server data reply: $error';
    }
  }

  String getCurrentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}