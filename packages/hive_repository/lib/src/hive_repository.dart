import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_repository/hive_repository.dart';

abstract class BaseHiveRepository {
  void addQRData(List<QRModel> qrData);
  Future<List<QRModel>> getQRData();
  void deleteQRData();

  void addID(String id);
  Future<String> getID();
  void deleteID();
  
  void addRawQR(String id);
  Future<String> getRawQR();
  void deleteRawQR();

  void close();
}

class HiveRepository extends BaseHiveRepository {
  // ===========================================
  static const String _boxName = 'SCANNER_BOX';
  static const String _keyName = 'QR_DATA';
  // ===========================================

  @override
  void addQRData(List<QRModel> qrData) async {
    var _box = Hive.isBoxOpen(_boxName)
    ? Hive.box(_boxName)
    : await Hive.openBox(_boxName);
    
    _box.put(_keyName, qrData);
  }

  @override
  Future<List<QRModel>> getQRData() async {
    var _box = Hive.isBoxOpen(_boxName)
    ? Hive.box(_boxName)
    : await Hive.openBox(_boxName);
    
    return _box.get(_keyName);
  }

  @override
  void deleteQRData() async {
    var _box = Hive.isBoxOpen(_boxName)
    ? Hive.box(_boxName)
    : await Hive.openBox(_boxName);
    
    _box.delete(_keyName);
  }

  // ====================================
  static const String _idBox = 'ID_BOX';
  static const String _idKey = 'ID_KEY';
  // ====================================

  @override
  void addID(String id) async {
    var _box = Hive.isBoxOpen(_idBox)
    ? Hive.box(_idBox)
    : await Hive.openBox(_idBox);
    
    _box.put(_idKey, id);
  }

  @override
  Future<String> getID() async {
    var _box = Hive.isBoxOpen(_idBox)
    ? Hive.box(_idBox)
    : await Hive.openBox(_idBox);
    return _box.get(_idKey);
  }

  @override
  void deleteID() async {
    var _box = Hive.isBoxOpen(_idBox)
    ? Hive.box(_idBox)
    : await Hive.openBox(_idBox);
    
    _box.delete(_idKey);
  }

  // ====================================
  static const String _qrRawBox = 'QR_RAW_BOX';
  static const String _qrRawKey = 'QR_RAW_KEY';
  // ====================================

  @override
  void addRawQR(String rawQRData) async {
    var _box = Hive.isBoxOpen(_qrRawBox)
    ? Hive.box(_qrRawBox)
    : await Hive.openBox(_qrRawBox);
    
    _box.put(_qrRawKey, rawQRData);
  }

  @override
  Future<String> getRawQR() async {
    var _box = Hive.isBoxOpen(_qrRawBox)
    ? Hive.box(_qrRawBox)
    : await Hive.openBox(_qrRawBox);
    
    return _box.get(_qrRawKey);
  }

  @override
  void deleteRawQR() async {
    var _box = Hive.isBoxOpen(_qrRawBox)
    ? Hive.box(_qrRawBox)
    : await Hive.openBox(_qrRawBox);
    
    _box.delete(_qrRawKey);
  }

  @override
  void close() async {
    if (Hive.isBoxOpen(_boxName)) {
      var _box = Hive.box(_boxName);
      return await _box.close();
    }
    if (Hive.isBoxOpen(_idBox)) {
      var _box = Hive.box(_idBox);
      return await _box.close();
    }
    if (Hive.isBoxOpen(_qrRawBox)) {
      var _box = Hive.box(_qrRawBox);
      return await _box.close();
    }
  }
}