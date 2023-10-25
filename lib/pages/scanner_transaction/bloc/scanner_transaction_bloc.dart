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
    on<ScannerTipValueChanged>(_onScannerTipValueChanged);
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
        final index2805 = dataList.indexWhere((e) => e.id == 'subs2805'); // Proxy-Notify Flags
        if (index2805 != -1) {
          final updatedDataList = List<QRModel>.from(dataList);
          emit(state.copyWith(notifyFlag: updatedDataList[index2805].data));
        }

        final index54 = dataList.indexWhere((e) => e.id == 'main54'); // transaction amount
        if (index54 != -1) {
          final updatedDataList = List<QRModel>.from(dataList);
          add(ScannerAmountValueChanged(updatedDataList[index54].data));
        }

        final index55 = dataList.indexWhere((e) => e.id == 'main55'); // tip
        if (index55 != -1) {
          final newList = List<QRModel>.from(dataList);
          switch(newList[index55].data) {
            case '01':
              emit(state.copyWith(tip: ''));
              break;
            case '02':
              final index56 = dataList.indexWhere((e) => e.id == 'main56');
              if(index56 != -1) {
                final newList = List<QRModel>.from(dataList);
                emit(state.copyWith(tip: newList[index56].data));
              }
              break;
            case '03':
              final index57 = dataList.indexWhere((e) => e.id == 'main57');
              if(index57 != -1) {
                final newList = List<QRModel>.from(dataList);
                emit(state.copyWith(tip: newList[index57].data));
              }
              break;
          }
        }
        // ======================================================================
      } else {
        emit(state.copyWith(status: Status.error, message: 'Empty'));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, message: e.toString()));
    }
  }

  void _onScannerTipValueChanged(ScannerTipValueChanged event, Emitter<ScannerTransactionState> emit) {
    final tip = event.tip;
    emit(state.copyWith(tip: tip));
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
    final index = state.qrDataList.indexWhere((e) => e.id == event.id); // returns -1 if [element] is not found.

    if (index != -1) { // index found
      final newList = List<QRModel>.from(state.qrDataList);
      newList[index] = newList[index].copyWith(data: event.data); // update list data base on new [event.data]
      emit(state.copyWith(qrDataList: newList));
    } else { // index not found
      if(event.id == 'subs6209A' || event.id == 'subs6209M' || event.id == 'subs6209E') {
        final newList = List<QRModel>.from(state.qrDataList);
        newList.add(QRModel(id: event.id, title: event.title, data: event.data, widget: event.widget));
        emit(state.copyWith(qrDataList: newList));
      }
    }
  }

  Future<void> _onScannerTransactionSubmitted(ScannerTransactionSubmitted event, Emitter<ScannerTransactionState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      
      if (_allExtraFieldsValid()) { // check if all extra fields are valid
        try {
          String result = _getFormSubmissionData().entries
          .map((e) => '${e.key}:${e.value}')
          .join(',');

          // additional fields
          String additional = _extraFieldSubmissionData().entries
          .map((e) => '${e.key}:${e.value}')
          .join(',');
          
          final rawQR = await _hiveRepository.getRawQR(); // raw qr data (unparsed qr data)
          final extra = _containsExtraFields() ? '|$additional' : '';
          final tipCon = state.qrDataList.indexWhere((e) => e.id == 'main55') != -1 ? '|${state.tip}' : '';
          
          final id = await _realtimeDBRepository.addUserRequest(
            UserRequest(
              dataRequest: "qr_transaction|${state.accountDropdown.value}|${state.inputAmount.value}$tipCon|$result$extra",
              extraData: rawQR,
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

  bool _containsExtraFields() { // check if textfields exist
    return state.qrDataList.any((e) => e.widget == 'textfield');
  }

  bool _allExtraFieldsValid() {
    final extraFields = state.qrDataList
    .where((e) => e.widget == 'textfield');
    //
    final extraFieldsValid = extraFields.isEmpty || extraFields
    .every((e) => e.data.isNotEmpty == true);
    //
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
    final pos1 = int.parse(state.notifyFlag.substring(0, 1));

    for (final qr in state.qrDataList) {
      if (qr.id == 'main59') {
        formData[qr.title] = qr.data;
      }
      if (qr.id == 'subs2803' && pos1 == 3) {
        formData[qr.title] = qr.data;
      }
      if (qr.id == 'subs2804') {
        formData[qr.title] = qr.data;
      }
      if (qr.id == 'subs6205') {
        formData[qr.title] = qr.data;
      }
    }
    return formData;
  }
}
