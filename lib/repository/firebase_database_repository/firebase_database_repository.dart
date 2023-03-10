import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:fcb_pay_app/repository/models/display_model.dart';

abstract class BaseFirebaseDatabaseRepository {
  Future<DisplayModel?> getDisplay();
  Future<void> deleteDisplay();
}

class FirebaseDatabaseRepository extends BaseFirebaseDatabaseRepository {
  FirebaseDatabaseRepository({FirebaseDatabase? firebaseDatabase})
    : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;
  final FirebaseDatabase _firebaseDatabase;

  @override
  Future<DisplayModel?> getDisplay() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var snapshot = await _firebaseDatabase.ref("display").child(userId).get();

    if (snapshot.value != null) {
      DisplayModel display = DisplayModel.fromSnapshot(snapshot);
      return display;
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteDisplay() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await _firebaseDatabase.ref("display").child(userId).remove();
  }
}