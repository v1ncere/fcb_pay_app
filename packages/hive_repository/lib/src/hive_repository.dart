import 'package:hive_flutter/hive_flutter.dart';

import '../hive_repository.dart';

class HiveRepository {
  // ====================== SCANNER =================
    static const String _scannerBox = 'SCANNER_BOX';
    static const String _scannerStaticKey = '5343';
  // ================================================

  Future<void> addQRDataList(List<QRModel> qrData) async {
    final box = await Hive.openBox<List<QRModel>>(_scannerBox);
    await box.put(_scannerStaticKey, qrData);
  }

  Future<List<QRModel>> getQRDataList() async {
    try {
      final box = await Hive.openBox<List<QRModel>>(_scannerBox);
      return box.get(_scannerStaticKey) ?? [];
    } catch (_) {
      return [];
    }
  }

  Future<void> deleteQRDataList() async {
    final box = await Hive.openBox<List<QRModel>>(_scannerBox);
    await box.delete(_scannerStaticKey);
  }

  Future<void> closeScannerBox() async {
    if (Hive.isBoxOpen(_scannerBox)) {
      final box = Hive.box<String>(_scannerBox);
      await box.close();
    }
  }

  // ================== ID ====================
    static const String _idBox = 'ID_BOX';
    static const String _idStaticKey = '1001';
  // ==========================================

  Future<void> addId(String id) async {
    final box = await Hive.openBox<String>(_idBox);
    await box.put(_idStaticKey, id);
  }

  Future<String> getId() async {
    try {
      final box = await Hive.openBox<String>(_idBox);
      return box.get(_idStaticKey) ?? '';
    } catch (_) {
      return '';
    }
  }

  Future<void> deleteId() async {
    final box = await Hive.openBox<String>(_idBox);
    await box.delete(_idStaticKey);
  }

  Future<void> closeIdBox() async {
    if (Hive.isBoxOpen(_idBox)) {
      final box = Hive.box<String>(_idBox);
      await box.close();
    }
  }

  // ================ QR RAW DATA ================
    static const String _qrRawBox = 'QR_RAW_BOX';
    static const String _qrRawStaticKey = '5152';
  // =============================================

  Future<void> addRawQR(String rawQRData) async {
    final box = await Hive.openBox<String>(_qrRawBox);
    await box.put(_qrRawStaticKey, rawQRData);
  }
  
  Future<String> getRawQR() async {
    try {
      final box = await Hive.openBox<String>(_qrRawBox);
      return box.get(_qrRawStaticKey) ?? '';
    } catch (_) {
      return '';
    }
  }
  
  Future<void> deleteRawQR() async {
    final box = await Hive.openBox<String>(_qrRawBox);
    await box.delete(_qrRawStaticKey);
  }

  Future<void> closeRawQrBox() async {
    if (Hive.isBoxOpen(_qrRawBox)) {
      final box = Hive.box<String>(_qrRawBox);
      await box.close();
    }
  }

  // ================== DEPOSIT =====================
    static const String _depositBox = 'DEPOSIT_BOX';
  // ================================================
  
  Future<void> addDepositId({
    required String uid,
    required String account
  }) async {
    final box = await Hive.openBox<String>(_depositBox);
    await box.put(uid, account);
  }
  
  Future<String> getDepositId(String uid) async {
    try {
      final box = await Hive.openBox<String>(_depositBox);
      return box.get(uid) ?? '';
    } catch (_) {
      return '';
    }
  }
  
  Future<void> deleteDepositId(String uid) async {
    final box = await Hive.openBox<String>(_depositBox);
    await box.delete(uid);
  }

  Future<void> closeDepositIdBox() async {
    if (Hive.isBoxOpen(_depositBox)) {
      final box = Hive.box<String>(_depositBox);
      await box.close();
    }
  }

  // ===================== CREDIT =================
    static const String _creditBox = 'CREDIT_BOX';
  // ==============================================
  
  Future<void> addCreditId({
    required String uid,
    required String account
  }) async {
    final box = await Hive.openBox<String>(_creditBox);
    await box.put(uid, account);
  }
  
  Future<String> getCreditId(String uid) async {
    try {
      final box = await Hive.openBox<String>(_creditBox);
      return box.get(uid) ?? '';
    } catch (_) {
      return '';
    }
  }
  
  Future<void> deleteCreditId(String uid) async {
    final box = await Hive.openBox<String>(_creditBox);
    await box.delete(uid);
  }
  
  Future<void> closeCreditIdBox() async {
    if (Hive.isBoxOpen(_creditBox)) {
      final box = Hive.box<String>(_creditBox);
      await box.close();
    }
  }

  // ========================= ONBOARDING =================
    static const String _onboardingBox = 'ONBOARDING_BOX';
    static const String _onBoardingStaticKey = '4f4e';
  // ======================================================
  
  Future<void> updateOnboarding(bool status) async {
    final box = await Hive.openBox<bool>(_onboardingBox);
    await box.put(_onBoardingStaticKey, status);
  }
  
  Future<bool> isOnboarded() async {
    try {
      final box = await Hive.openBox<bool>(_onboardingBox);
      return box.get(_onBoardingStaticKey) ?? false;
    } catch (_) {
      return false;
    }
  }
  
  Future<void> deleteOnBoarding() async {
    final box = await Hive.openBox<bool>(_onboardingBox);
    await box.delete(_onBoardingStaticKey);
  }
  
  Future<void> closeOnboardingBox() async {
    if (Hive.isBoxOpen(_onboardingBox)) {
      final box = Hive.box<bool>(_onboardingBox);
      await box.close();
    }
  }
}