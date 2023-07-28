import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_repository/hive_repository.dart';

abstract class BaseHiveRepository {
  void addQRData(List<QRModel> qrData);
  Future<List<QRModel>> getQRData();
  void deleteQRData();
  void close();
}

class HiveRepository extends BaseHiveRepository {
  static const String _boxName = 'Scanner_BOX';
  static const String _keyName = 'QR_data';

  @override
  void addQRData(List<QRModel> qrData) async {
    var box = Hive.isBoxOpen(_boxName)
      ? Hive.box(_boxName)
      : await Hive.openBox(_boxName);
    box.put(_keyName, qrData);
  }

  @override
  Future<List<QRModel>> getQRData() async {
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