import 'package:hive_flutter/hive_flutter.dart';

abstract class BaseHiveRepository {
  void addQRData(List qrData);
  void deleteQRData();
  void close();
  Future<List> getQRData();
}

class HiveRepository extends BaseHiveRepository {
  static const String _boxName = 'Scanner_BOX';
  static const String _keyName = 'QR_data';

  @override
  void addQRData(List qrData) async {
    var box = Hive.isBoxOpen(_boxName)
      ? Hive.box(_boxName)
      : await Hive.openBox(_boxName);
    box.put(_keyName, qrData);
  }

  @override
  Future<List> getQRData() async {
    var box = Hive.isBoxOpen(_boxName)
      ? Hive.box(_boxName)
      : await Hive.openBox(_boxName);
    return box.get(_keyName);
  }

  @override
  void deleteQRData() async {
    var box = Hive.isBoxOpen(_boxName)
      ? Hive.box(_boxName)
      : await Hive.openBox(_boxName);
    box.delete(_keyName);
  }

  @override
  void close() async {
    if (Hive.isBoxOpen(_boxName)) {
      var box = Hive.box(_boxName);
      return await box.close();
    }
  }
}