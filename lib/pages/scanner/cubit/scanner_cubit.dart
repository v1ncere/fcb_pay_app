import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/utils/qr_utils.dart';

part 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  final HiveRepository _hiveRepository;
  ScannerCubit({
    required HiveRepository hiveRepository
  }): _hiveRepository = hiveRepository,
  super(const ScannerState());


  void saveQRCode(String data) async {
    emit(state.copyWith(status: ScannerStateStatus.loading));
    
    if(data.isEmpty) {
      emit(state.copyWith(
        message: 'Empty QR code data. Please ensure that the QR code contains valid information and try again.',
        status: ScannerStateStatus.failure
      ));
      return;
    }

    try {
      int len = data.length;
      String qrCrc = data.substring(len - 4, len);
      String calcCrc = crc16CCITT(data.substring(0, len - 4));

      if(qrCrc == calcCrc) {
        _hiveRepository.addQRData(qrDataParser(data));
        emit(state.copyWith(status: ScannerStateStatus.success));
      } else {
        throw Exception('Invalid QR code. Please ensure that the QR code is not damaged and that it belongs to this service.');
      }
    } catch (e) {
      emit(state.copyWith(
        status: ScannerStateStatus.failure,
        message: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }
}
