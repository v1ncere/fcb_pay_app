import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  final HiveRepository _hiveRepository;
  ScannerCubit({
    required HiveRepository hiveRepository
  })  : _hiveRepository = hiveRepository,
  super(const ScannerState());

  void saveQRCode(String data) async {
    emit(state.copyWith(status: Status.loading));
    
    try {
      if(data.isEmpty) {
        throw QRCodeFailure.fromCode('qr-empty');
      }

      if(_validateQRCodeCRC(data)) {
        final qrObjectList = qrDataParser(data); // parse qr data into List<QRModel>
        
        if (_validateQRObjects(qrObjectList)) {
          _hiveRepository.addQRData(qrObjectList);
          emit(state.copyWith(status: Status.success));
        }
      } else {
        throw QRCodeFailure.fromCode('crc-not-match');
      }
    } on QRCodeFailure catch(e) {
      emit(state.copyWith(status: Status.error, message: e.message));
    } 
    catch (e) {
      emit(state.copyWith(
        status: Status.error,
        message: e.toString().replaceAll('Exception: ', '')
      ));
    }
  }

  bool _validateQRCodeCRC(String data) {
    int len = data.length; // qr length
    String qrCrcCCITT = data.substring(len - 4); // last 4 characters, location of the CRC
    String calcCrcCCITT = crc16CCITT(data.substring(0, len - 4)); // CRC
    
    return qrCrcCCITT == calcCrcCCITT;
  }

  bool _validateQRObjects(List<QRModel> qrObjectList) {
    bool id27 = false;
    bool id28 = false;
    bool id2803 = false;
    bool id2804 = false;

    for (QRModel qr in qrObjectList) {
      if (qr.id.substring(0, 6) == 'subs27') {
        id27 = true;
      }
      if (qr.id.substring(0, 6) == 'subs28') {
        id28 = true;
      }
      if (qr.id.contains('subs2803')) {
        id2803 = true;
      }
      if (qr.id.contains('subs2804')) {
        id2804 = true;
      }
    }

    if (id27 && id28) {
      throw QRCodeFailure.fromCode('invalid-mai');
    }
    if (!id2803 && !id2804) {
      throw QRCodeFailure.fromCode('no-merchant-id');
    }

    return true;
  }
}