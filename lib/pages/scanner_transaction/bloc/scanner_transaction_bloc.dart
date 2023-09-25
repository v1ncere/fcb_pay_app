import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'scanner_transaction_event.dart';
part 'scanner_transaction_state.dart';

class ScannerTransactionBloc extends Bloc<ScannerTransactionEvent, ScannerTransactionState> {
  ScannerTransactionBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
    required HiveRepository hiveRepository
  }) : _realtimeDBRepository = firebaseRepository,
  _hiveRepository = hiveRepository,
  super(const ScannerTransactionState()) {
    on<ScannerTransactionDisplayLoaded>(_onScannerTransactionDisplayLoaded);
    on<ScannerAccountValueChanged>(_onScannerAccountValueChanged);
    on<ScannerAmountValueChanged>(_onScannerAmountValueChanged);
    on<ScannerTransactionSubmitted>(_onScannerTransactionSubmitted);
  }
  final HiveRepository _hiveRepository;
  final FirebaseRealtimeDBRepository _realtimeDBRepository;

  void _onScannerTransactionDisplayLoaded(ScannerTransactionDisplayLoaded event, Emitter<ScannerTransactionState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final dataList = List<QRModel>.from(await _hiveRepository.getQRData());
      
      if (dataList.isNotEmpty) {
        emit(state.copyWith(qrDataList: dataList, status: Status.success));
      } else {
        throw Exception('Empty');
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, message: e.toString()));
    }
  }

  void _onScannerAccountValueChanged(ScannerAccountValueChanged event, Emitter<ScannerTransactionState> emit) {
    final acc = AccountDropdown.dirty(event.account);
    emit(state.copyWith(accountDropdown: acc));
  }

  void _onScannerAmountValueChanged(ScannerAmountValueChanged event, Emitter<ScannerTransactionState> emit) {
    final amt = Amount.dirty(event.amount);
    emit(state.copyWith(inputAmount: amt));
  }

  Future<void> _onScannerTransactionSubmitted(ScannerTransactionSubmitted event, Emitter<ScannerTransactionState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      
      String result = _getFormSubmissionData().entries
      .map((entry) => '${entry.key}:${entry.value}')
      .join(',');

      try {
        final id = await _realtimeDBRepository.addUserRequest(
          UserRequest(
            dataRequest: "qr_bills_payment|${state.accountDropdown.value}|${state.inputAmount.value}|$result",
            ownerId: FirebaseAuth.instance.currentUser!.uid,
            timeStamp: DateTime.now()
          )
        );

        _hiveRepository.addID(id!); // add [id] to hive (local DB)
        emit(state.copyWith(formStatus: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(message: e.toString(), formStatus: FormzSubmissionStatus.failure));
      }
    } else {
      emit(state.copyWith(
        message: "Incomplete Form: Please review the form and fill in all required fields.",
        formStatus: FormzSubmissionStatus.failure
      ));
    }
  }

  Map<String, String> _getFormSubmissionData() {
    final Map<String, String> formData = {};

    for (final qr in state.qrDataList) {
      if (qr.id == 'subs2803' || qr.id == 'main59' || qr.id == 'subs6205') {
        formData[qr.title] = qr.data;
      }
    }
    return formData;
  }
}
