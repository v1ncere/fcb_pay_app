import 'package:hive_flutter/hive_flutter.dart';

class HivePinRepository {
  static const String _boxName = 'PIN_BOX';
  static const String _keyName = 'PIN_KEY';

  static const String _biometricBox = 'BIO_BOX';
  static const String _biometricKey = 'BIO_KEY';

  // ============= PIN =================================
  // ===================================================

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

  Future<bool> pinExists() async {
    Box<String> box = Hive.isBoxOpen(_boxName)
    ? Hive.box(_boxName)
    : await Hive.openBox(_boxName);
    
    return box.get(_keyName)?.isNotEmpty == true;
  }
  
  Future<void> deletePin() async {
    Box<String> box = Hive.isBoxOpen(_boxName)
    ? Hive.box(_boxName)
    : await Hive.openBox(_boxName);
    
    return box.delete(_keyName);
  }

  // ============= BIOMETRICS =============================
  // ======================================================

  void addBiometrics(bool isEnabled) async {
    Box<bool> box = Hive.isBoxOpen(_biometricBox)
    ? Hive.box(_biometricBox)
    : await Hive.openBox(_biometricBox);
    
    box.put(_biometricKey, isEnabled);
  }

  Future<bool> isBiometricsUserEnable() async {
    Box<bool> _box = Hive.isBoxOpen(_biometricBox)
    ? Hive.box(_biometricBox)
    : await Hive.openBox(_biometricBox);
    
    return _box.get(_biometricKey) ?? false;
  }

  void closePinBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      Box<String> _box = Hive.box(_boxName);
      return await _box.close();
    }
  }

  void closeBioBox() async {
    if (Hive.isBoxOpen(_biometricBox)) {
      Box<bool> _box = Hive.box(_biometricBox);
      return await _box.close();
    }
  }
}