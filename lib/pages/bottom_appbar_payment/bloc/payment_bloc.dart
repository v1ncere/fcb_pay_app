import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';


part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _firebaseRealtimeDBRepository = firebaseRealtimeDBRepository,
  super(const PaymentState()) {
    on<PaymentTransactionAmountChanged>(_onPaymentTransactionAmountChanged);
    on<InstitutionValueChanged>(_onInstitutionSelectionChanged);
    on<AccountValueChanged>(_onAccountSelectionChanged);
    on<PaymentSubmitted>(_onPaymentSubmitted);
    on<ControllerValueChanged>(_onControllerValueChanged);
    on<ControllerValueRemoved>(_onControllerValueRemoved);
  }
  final FirebaseRealtimeDBRepository _firebaseRealtimeDBRepository;

  void _onPaymentTransactionAmountChanged(PaymentTransactionAmountChanged event, Emitter<PaymentState> emit) {
    final amount = Amount.dirty(event.amount);
    emit(state.copyWith(amount: amount));
  }

  void _onInstitutionSelectionChanged(InstitutionValueChanged event, Emitter<PaymentState> emit) {
    final institutionDropdown = InstitutionDropdown.dirty(event.institution);
    emit(state.copyWith(institutionDropdown: institutionDropdown));
  }

  void _onAccountSelectionChanged(AccountValueChanged event, Emitter<PaymentState> emit) {
    final accountDropdown = AccountDropdown.dirty(event.account);
    emit(state.copyWith(accountDropdown: accountDropdown));
  }

  void _onControllerValueChanged(ControllerValueChanged event, Emitter<PaymentState> emit) {
    final List<TextEditingController> controllers = List.from(state.controllers)..add(event.controller);
    final List<TextField> textfields = List.from(state.fields)..add(event.field);
    
    emit(state.copyWith(controllers: controllers, fields: textfields, fieldList: event.fieldList));
  }

  void _onControllerValueRemoved(ControllerValueRemoved event, Emitter<PaymentState> emit) {
    final List<TextEditingController> controllers = List.from(state.controllers)..clear();
    final List<TextField> textfields = List.from(state.fields)..clear();
    
    emit(state.copyWith(controllers: controllers, fields: textfields));
  }

  Future<void> _onPaymentSubmitted(PaymentSubmitted event, Emitter<PaymentState> emit) async {
    List<String> inputList = state.controllers
      .where((element) => element.value.text.isNotEmpty)
      .map((element) => element.value.text)
      .toList();

    Map<String, String> listMerge = {};
    String merged = "";
  
    if (state.fieldList.isNotEmpty) {
      for (int i = 0; i < inputList.length; i++) {
        listMerge[state.fieldList[i]] = inputList[i];
      }

      merged = listMerge.toString();
      merged = merged.substring(1, merged.length - 1);
    }
    
    final fields = state.controllers.isEmpty ? "" : "|$merged";
    final account = event.account.isEmpty ? state.accountDropdown.value : event.account;

    if (state.isValid) {
      if ((state.controllers.isEmpty) || (state.controllers.isNotEmpty && state.controllers.length == inputList.length)) {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        try {
          await _firebaseRealtimeDBRepository.addUserAccount(
            UserRequest(
              dataRequest: "bills_payment|$account|${state.institutionDropdown.value}|${state.amount.value}$fields",
              ownerId: FirebaseAuth.instance.currentUser!.uid,
              timeStamp: DateTime.now()
            )
          );
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } catch (e) {
          emit(state.copyWith(
            error: e.toString(),
            status: FormzSubmissionStatus.failure
          ));  
        }
      } else {
        emit(state.copyWith(
          error: "Incomplete Form: Please review the form and fill in all additional fields.",
          status: FormzSubmissionStatus.failure
        ));
      }
    } else {
      emit(state.copyWith(
        error: "Incomplete Form: Please review the form and fill in all required fields.",
        status: FormzSubmissionStatus.failure
      ));
    }
  }
}
