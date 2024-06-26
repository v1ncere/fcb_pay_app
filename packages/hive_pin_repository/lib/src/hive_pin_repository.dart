import 'package:hive_flutter/hive_flutter.dart';

class HivePinRepository {

  // ============= PIN ===============================
    static const String _pinAuthBox = 'PIN_AUTH_BOX';
  // =================================================

  Future<void> addPinAuth({
    required String uid,
    required String pin
  }) async {
    final box = await Hive.openBox<String>(_pinAuthBox);
    await box.put(uid, pin);
  }

  Future<bool> pinAuthEquals({
    required String uid,
    required String pin
  }) async {
    try {
      final box = await Hive.openBox<String>(_pinAuthBox);
      final authPin = box.get(uid);
      return authPin != null && authPin == pin;
    } catch (_) {
      return false;
    }
  }

  Future<bool> isPinAuthExist(String uid) async {
    final box = await Hive.openBox<String>(_pinAuthBox);
    return box.containsKey(uid);
  }
  
  Future<void> deletePinAuth(String uid) async {
    final box = await Hive.openBox<String>(_pinAuthBox);
    await box.delete(uid);
  }

  Future<void> closePinAuthBox() async {
    if (Hive.isBoxOpen(_pinAuthBox)) {
      final box = Hive.box<String>(_pinAuthBox);
      await box.close();
    }
  }

  // ========================== BIOMETRICS ==============
    static const String _biometricBox = 'BIOMETRIC_BOX';
    static const String _biometricStaticKey = '4249';
  // ====================================================

  Future<void> addBiometricStatus(bool status) async {
    final box = await Hive.openBox<bool>(_biometricBox);
    await box.put(_biometricStaticKey, status);
  }

  Future<bool> getBiometricStatus() async {
    try {
      final box = await Hive.openBox<bool>(_biometricBox);
      return box.get(_biometricStaticKey) ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> closeBiometricBox() async {
    if (Hive.isBoxOpen(_biometricBox)) {
      final box = Hive.box<bool>(_biometricBox);
      await box.close();
    }
  }
}