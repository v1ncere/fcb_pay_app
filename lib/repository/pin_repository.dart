import 'package:hive_flutter/hive_flutter.dart';

abstract class PinRepository {
  void close();
  void addPin(String pin);
  Future<bool> pinEquals(String pin);
}

class HivePinRepository extends PinRepository {
  static const String _boxName = 'pin_box';
  static const String _keyName = 'pin_key';

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
      var v = await box.close();
      return v;
      // return await Hive.box(_boxName).close();
    }
  }
}