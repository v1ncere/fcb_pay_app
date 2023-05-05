import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

part 'payment_confirmation_event.dart';
part 'payment_confirmation_state.dart';

class PaymentConfirmationBloc extends Bloc<PaymentConfirmationEvent, PaymentConfirmationState> {
  final HiveRepository _hiveRepository;
  PaymentConfirmationBloc({
    required HiveRepository hiveRepository,
  }): _hiveRepository = hiveRepository,
  super(const PaymentConfirmationState()) {
    on<PaymentConfirmationLoaded>(_onPaymentDisplay);
    on<PaymentConfirmationDisplayDelete>(_onDeletePayment);
  }

  void _onPaymentDisplay(
    PaymentConfirmationLoaded event,
    Emitter<PaymentConfirmationState> emit
  ) async {
    emit(state.copyWith(status: PaymentConfirmationStatus.loading));
    
    try {
      var display = await _hiveRepository.getQRData();

      if (display.isNotEmpty) {
        String datas = display.join('\n');
        emit(
          state.copyWith(
            status: PaymentConfirmationStatus.success,
            display: datas,
          )
        );
      } else {
        throw Exception('Empty');
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentConfirmationStatus.failure,
          error: 'Empty',
        )
      );
    }
  }

  void _onDeletePayment(
    PaymentConfirmationDisplayDelete event,
    Emitter<PaymentConfirmationState> emit
  ) {
    _hiveRepository.deleteQRData();
  }
}
