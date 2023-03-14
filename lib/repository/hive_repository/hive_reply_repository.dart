import 'package:fcb_pay_app/repository/repository.dart';
import 'package:hive_flutter/adapters.dart';

abstract class BaseHiveReplyRepository {
  Future<Box> replyBox();
  Future<List<ReplyModel>> getReplies();
  Future<void> addReply(ReplyModel model);
  Future<void> putReply(String key, ReplyModel model);
  Future<void> deleteReply(String key);
  Future<void> clearReply();
}

class HiveReplyRepository extends BaseHiveReplyRepository {
  final String _boxName = "REPLY";

  @override
  Future<Box> replyBox() async {
    Box box = await Hive.openBox<ReplyModel>(_boxName);
    return box;
  }

  @override
  Future<List<ReplyModel>> getReplies() async {
    final Box box = await replyBox();
    return box.values.toList().cast<ReplyModel>();
  }

  @override
  Future<void> addReply(ReplyModel model) async {
    final Box box = await replyBox();
    await box.add(model);
  }

  @override
  Future<void> putReply(String key, ReplyModel model) async {
    final Box box = await replyBox();
    await box.put(key, model);
  }

  @override
  Future<void> deleteReply(String key) async {
    final Box box = await replyBox();
    await box.delete(key);
  }

  @override
  Future<void> clearReply() async {
    final Box box = await replyBox();
    await box.clear();
  }
} 