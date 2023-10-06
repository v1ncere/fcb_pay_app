import 'package:hive_flutter/hive_flutter.dart';

class HivePinRepository {
  static const String _boxName = 'PIN_BOX';
  static const String _keyName = 'PIN_KEY';

  void addPin(String pin) async {
    Box<String> box = Hive.isBoxOpen(_boxName)
    ? Hive.box(_boxName)
    : await Hive.openBox(_boxName);
    box.put(_keyName, pin);
  }

  Future<bool> pinEquals(String pin) async {
    Box<String> box = Hive.isBoxOpen(_boxName)
    ? Hive.box(_boxName)
    : await Hive.openBox(_boxName);
    return box.get(_keyName, defaultValue: _keyName) == pin;
  }

  void close() async {
    if (Hive.isBoxOpen(_boxName)) {
      Box<String> box = Hive.box(_boxName);
      return await box.close();
    }
  }
}