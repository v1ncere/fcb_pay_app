import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

part 'scanner_display_event.dart';
part 'scanner_display_state.dart';

class ScannerDisplayBloc extends Bloc<ScannerDisplayEvent, ScannerDisplayState> {
  ScannerDisplayBloc({
    required HiveRepository hiveRepository
  }) : _hiveRepository = hiveRepository,
  super(const ScannerDisplayState()) {
    on<ScannerDisplayLoaded>(_onScannerDisplay);
  }
  final HiveRepository _hiveRepository;

  void _onScannerDisplay(ScannerDisplayLoaded event, Emitter<ScannerDisplayState> emit) async {
    emit(state.copyWith(status: ScannerDisplayStatus.loading));

    try {
      final dataList = List<QRModel>.from(await _hiveRepository.getQRData());
      if (dataList.isNotEmpty) {
        emit(state.copyWith(qrData: dataList, status: ScannerDisplayStatus.success));
      } else {
        throw Exception('Empty');
      }
    } catch (e) {
      emit(state.copyWith(status: ScannerDisplayStatus.failure, error: e.toString()));
    }
  }
}

// data: (intire qr data), pattern: (qr data id's) sub<<mainId><subId>> or main<id>
String dataSelector(String data, String pattern) {
  int index = data.indexOf(pattern) + pattern.length;
  int newIndex = index + 2;
  int length = int.parse(data.substring(index, newIndex));
  String result = data.substring(newIndex, newIndex + length);
  return result;
}
