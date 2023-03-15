import 'package:fcb_pay_app/repository/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';

abstract class BaseHiveServerReplyRepository {
  Future<Box> serverReplyBox();
  Future<List<ServerReply>> getServerReplies();
  Future<ServerReply>? getServerReply(String tag);
  Future<void> addServerReply(ServerReply model);
  Future<void> updateServerReply(String key, ServerReply model);
  Future<void> deleteServerReply(String key);
  Future<void> clearServerReply();
}

class HiveServerReplyRepository extends BaseHiveServerReplyRepository {
  static const String _boxName = "SERVER_REPLY_BOX";

  @override
  Future<Box> serverReplyBox() async {
    Box box = Hive.isBoxOpen(_boxName)
      ? Hive.box<ServerReply>(_boxName)
      : await Hive.openBox<ServerReply>(_boxName);
    return box;
  }

  // @override
  // Future<Box> serverReplyBox() async {
  //   Box box = await Hive.openBox<ServerReply>(_boxName);
  //   return box;
  // }

  @override
  Future<List<ServerReply>> getServerReplies() async {
    final Box box = await serverReplyBox();
    return box.values.toList().cast<ServerReply>();
  }

  @override
  Future<ServerReply>? getServerReply(String tag) async {
    final Box box = await serverReplyBox();

    // Retrieve all objects from the box
    final allServerReplies = box.values;

    // Find the first object that matches the specified data
    final serverReply = allServerReplies.firstWhere(
      (reply) => reply.tag == tag,
      orElse: () => null,
    );

    return serverReply;
  }

  @override
  Future<void> addServerReply(ServerReply model) async {
    final Box box = await serverReplyBox();

    // functions for hash data here neggas

    await box.add(model);
  }

  @override
  Future<void> updateServerReply(String key, ServerReply model) async {
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

  String getCurrentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
} 