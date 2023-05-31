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
        status: ScannerStateStatus.failure,
        message: 'Empty QR code data. Please ensure that the QR code contains valid information and try again.',
      ));
      return;
    }

    try {
      String dataCRC = data.substring(data.length - 4, data.length);
      String calculatedCRC = crc16CCITT(data.substring(0, data.length - 4));

      if(dataCRC == calculatedCRC) {
        List model = [];
        for (var element in qrDataParser(data)) {
          model.add(element);
        }
        _hiveRepository.addQRData(model);
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
