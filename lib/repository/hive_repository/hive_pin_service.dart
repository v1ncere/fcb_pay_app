import 'package:hive_flutter/hive_flutter.dart';

abstract class BaseHivePinService {
  void close();
  void addPin(String pin);
  Future<bool> pinEquals(String pin);
}

class HivePinService extends BaseHivePinService {
  static const String _boxName = 'PIN_BOX';
  static const String _keyName = 'PIN_KEY';

  @override
  void addPin(String pin) async {
    Box<String> box = Hive.isBoxOpen(_boxName)
      ? Hive.box(_boxName)
      : await Hive.openBox(_boxName);
    box.put(_keyName, pin);
  }

  @override
  Future<bool> pinEquals(String pin) async {
    Box<String> box = Hive.isBoxOpen(_boxName)
      ? Hive.box(_boxName)
      : await Hive.openBox(_boxName);
    return box.get(_keyName, defaultValue: _keyName) == pin;
  }

  @override
  void close() async {
    if (Hive.isBoxOpen(_boxName)) {
      Box<String> box = Hive.box(_boxName);
      return await box.close();
    }
  }
}