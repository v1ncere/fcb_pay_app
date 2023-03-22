import 'package:fcb_pay_app/repository/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';

abstract class BaseHiveHomeDisplayService {
  Future<Box> serverReplyBox();
  Future<List<HomeDisplay?>> getServerReplies();
  Future<HomeDisplay?> getServerReply(String tag);
  Future<void> addServerReply(HomeDisplay model);
  Future<void> updateServerReply(String key, HomeDisplay model);
  Future<void> deleteServerReply(String key);
  Future<void> clearServerReply();
}

class HiveHomeDisplayService extends BaseHiveHomeDisplayService {
  final String _boxName = "SERVER_REPLY_BOX";

  @override
  Future<Box> serverReplyBox() async {
    Box box = await Hive.openBox<HomeDisplay>(_boxName);
    return box;
  }

  @override
  Future<List<HomeDisplay?>> getServerReplies() async {
    final Box box = await serverReplyBox();
    return box.values.toList().cast<HomeDisplay>();
  }

  @override
  Future<HomeDisplay?> getServerReply(String tag) async {
    final Box box = await serverReplyBox();
    final serverReply = box.get(tag);

    return serverReply;
  }

  /// Add the server reply from firebasedatabase
  @override
  Future<void> addServerReply(HomeDisplay model) async {
    final Box box = await serverReplyBox();
    // functions for hash data here

    await box.put(model.ownerId, model);
  }

  @override
  Future<void> updateServerReply(String key, HomeDisplay model) async {
    final Box box = await serverReplyBox();
    await box.put(key, model);
  }

  @override
  Future<void> deleteServerReply(String key) async {
    final Box box = await serverReplyBox();
    await box.delete(key);
  }

  @override
  Future<void> clearServerReply() async {
    final Box box = await serverReplyBox();
    await box.clear();
  }

  // get the user id
  String getCurrentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
} 