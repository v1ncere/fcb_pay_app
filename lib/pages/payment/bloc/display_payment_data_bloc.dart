import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

part 'display_payment_data_event.dart';
part 'display_payment_data_state.dart';

class DisplayPaymentDataBloc extends Bloc<DisplayPaymentDataEvent, DisplayPaymentDataState> {
  final HiveRepository _hiveRepository;
  DisplayPaymentDataBloc({
    required HiveRepository hiveRepository
  }): _hiveRepository = hiveRepository, 
  super(const DisplayPaymentDataState()) {
    on<DisplayPaymentDataLoaded>(_onDisplayPaymentData);
  }

  void _onDisplayPaymentData(
    DisplayPaymentDataLoaded event,
    Emitter<DisplayPaymentDataState> emit
  ) async {
    emit(state.copyWith(status: DisplayPaymentDataStatus.progress));

    try {
      var dataList = await _hiveRepository.getQRData();
      if (dataList.isNotEmpty) {
        String data = dataList.join('');
        emit(
          state.copyWith(
            merchantId: dataSelector(data, 'sub2803'),
            merchantName: dataSelector(data, 'main59'),
            referenceLabel: dataSelector(data, 'sub6205'),
            senderTransactionRef: '09234020394',
            traceNumber: '23412342943898345',
            status: DisplayPaymentDataStatus.success
          )
        );
      } else {
        throw Exception('Empty');
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: DisplayPaymentDataStatus.failure,
          error: e.toString(),
        )
      );
    }
  }
}

// data == (qr data), pattern == (qr data id) main{id}|sub{id}
String dataSelector(String data, String pattern) {
  int index = data.indexOf(pattern) + pattern.length;
  int newIndex = index + 2;
  int length = int.parse(data.substring(index, newIndex));
  String result = data.substring(newIndex, newIndex + length);
  return result;
}