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
  })  : _realtimeDBRepository = firebaseRepository,
  _hiveRepository = hiveRepository,
  super(const ScannerTransactionState()) {
    on<ScannerTransactionDisplayLoaded>(_onScannerTransactionDisplayLoaded);
    on<ScannerAccountValueChanged>(_onScannerAccountValueChanged);
    on<ScannerAccountModelChanged>(_onScannerAccountModelChanged);
    on<ScannerAmountValueChanged>(_onScannerAmountValueChanged);
    on<ScannerExtraWidgetValueChanged>(_onScannerExtraWidgetValueChanged);
    on<ScannerTransactionSubmitted>(_onScannerTransactionSubmitted);
  }
  final HiveRepository _hiveRepository;
  final FirebaseRealtimeDBRepository _realtimeDBRepository;

  void _onScannerTransactionDisplayLoaded(ScannerTransactionDisplayLoaded event, Emitter<ScannerTransactionState> emit) async {
    emit(state.copyWith(status: Status.loading));
    
    try {
      final dataList = List<QRModel>.from(await _hiveRepository.getQRData());
      
      if (dataList.isNotEmpty) {
        emit(state.copyWith(status: Status.success, qrDataList: dataList));

        // ====================================================================== 
        final index = dataList.indexWhere((element) => element.id == 'subs2805');
        if (index != -1) {
          final updatedDataList = List<QRModel>.from(dataList);
          emit(state.copyWith(notifyFlag: updatedDataList[index].data));
        }
        // ======================================================================
      } else {
        emit(state.copyWith(status: Status.error, message: 'Empty'));
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

  void _onScannerAccountModelChanged(ScannerAccountModelChanged event, Emitter<ScannerTransactionState> emit) {
    final acc = event.account;
    emit(state.copyWith(account: acc));
  }

  void _onScannerExtraWidgetValueChanged(ScannerExtraWidgetValueChanged event, Emitter<ScannerTransactionState> emit) {
    final index = state.qrDataList.indexWhere((element) => element.id == event.id); // returns -1 if [element] is not found.

    if (index != -1) {
      final updatedQrDataList = List<QRModel>.from(state.qrDataList);
      updatedQrDataList[index] = updatedQrDataList[index].copyWith(data: event.data);
      
      emit(state.copyWith(qrDataList: updatedQrDataList));
    }
  }

  Future<void> _onScannerTransactionSubmitted(ScannerTransactionSubmitted event, Emitter<ScannerTransactionState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      
      if (_allExtraFieldsValid()) {
        try {
          String result = _getFormSubmissionData().entries
          .map((e) => '${e.key}:${e.value}')
          .join(',');

          String additional = _extraFieldSubmissionData().entries
          .map((e) => '${e.key}:${e.value}')
          .join(',');

          final extra = _containsExtraFields() ? '|$additional' : '';
          
          final id = await _realtimeDBRepository.addUserRequest(
            UserRequest(
              dataRequest: "qr_transactions|${state.accountDropdown.value}|${state.inputAmount.value}|$result$extra",
              ownerId: FirebaseAuth.instance.currentUser!.uid,
              timeStamp: DateTime.now()
            )
          );

          _hiveRepository.addID(id!); // add [id] to hive (local DB)
          emit(state.copyWith(formStatus: FormzSubmissionStatus.success));
        } catch (e) {
          emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.toString()));
        }
      } else {
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.failure,
          message: "Incomplete Form: Please review the form and fill in all required fields."
        ));
      }
    } else {
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.failure,
        message: "Incomplete Form: Please review the form and fill in all required fields."
      ));
    }
  }

  bool _containsExtraFields() {
    return state.qrDataList.any((element) {
      return element.widget == 'textfield';
    });
  }

  bool _allExtraFieldsValid() {
    final extraFields = state.qrDataList
    .where((element) => element.widget == 'textfield');
    //
    final extraFieldsValid = extraFields.isEmpty || extraFields
    .every((element) => element.data.isNotEmpty == true);

    return extraFieldsValid;
  }

  Map<String, String> _extraFieldSubmissionData() {
    final Map<String, String> extraFieldsList = {};

    for (final extra in state.qrDataList) {
      if (extra.widget == 'textfield') {
        extraFieldsList[extra.data] = extra.data;
      }
    }
    return extraFieldsList;
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
