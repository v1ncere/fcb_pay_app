import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<PaymentTransactionAmountChanged>(_onPaymentTransactionAmountChanged);
    on<PaymentSubmitted>(_onPaymentSubmitted);
  }

  void _onPaymentTransactionAmountChanged(
    PaymentTransactionAmountChanged event,
    Emitter<PaymentState> emit
  ) {
    final amt = Amount.dirty(event.amount);
    emit(state.copyWith(amount: amt));
  }

  void _onPaymentSubmitted(
    PaymentSubmitted event,
    Emitter<PaymentState> emit
  ) {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            errorMsg: e.toString(),
            status: FormzSubmissionStatus.failure
          )
        );  
      }
    }
  }
}
