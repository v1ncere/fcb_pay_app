import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'scanner_transaction_event.dart';
part 'scanner_transaction_state.dart';

class ScannerTransactionBloc extends Bloc<ScannerTransactionEvent, ScannerTransactionState> {
  ScannerTransactionBloc() : super(const ScannerTransactionState()) {
    on<ScannerAccountValueChanged>(_onScannerAccountValueChanged);
    on<ScannerTransactionSubmitted>(_onScannerTransactionSubmitted);
  }

  void _onScannerAccountValueChanged(ScannerAccountValueChanged event, Emitter<ScannerTransactionState> emit) {
    final amount = Amount.dirty(event.amount);
    emit(state.copyWith(amount: amount));
  }

  Future<void> _onScannerTransactionSubmitted(ScannerTransactionSubmitted event, Emitter<ScannerTransactionState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            error: e.toString(),
            status: FormzSubmissionStatus.failure
          )
        ); 
      }
    }
  }
}
