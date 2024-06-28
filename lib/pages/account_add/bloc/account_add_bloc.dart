import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';

part 'account_add_event.dart';
part 'account_add_state.dart';

class AccountAddBloc extends Bloc<AccountAddEvent, AccountAddState> {
  AccountAddBloc({
    required FirebaseRealtimeDBRepository firebaseDatabase,
  })  : _firebaseDatabase = firebaseDatabase, 
  super(AccountAddState(birthdateController: TextEditingController())) {
    on<AccountTypeDropdownChanged>(_onAccountTypeDropdownChanged);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthdateChanged>(_onBirthdateChanged);
    on<AccountFormSubmitted>(_onAccountFormSubmitted);
    on<AccountVerified>(_onAccountVerified);
    on<AccountVerifyReplyFetched>(_onAccountVerifyReplyFetched);
    on<AccountVerifyReplyUpdated>(_onAccountVerifyReplyUpdated);
    on<AccountStatusRefresher>(_onAccountStatusRefresher);
  }
  final FirebaseRealtimeDBRepository _firebaseDatabase;
  StreamSubscription<AccountVerify>? _streamSubscription;

  void _onAccountTypeDropdownChanged(AccountTypeDropdownChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(accountType: event.accountType));
  }

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(accountNumber: AccountNumber.dirty(event.accountNumber)));
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(firstName: Name.dirty(event.firstName)));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(lastName: Name.dirty(event.lastName)));
  }

  void _onBirthdateChanged(BirthdateChanged event, Emitter<AccountAddState> emit) {
    final dateString = DateFormat('dd/MM/yyyy').format(event.date);
    final controller = TextEditingController(text: dateString);
    emit(state.copyWith(birthdateController: controller));
  }

  void _onAccountStatusRefresher(AccountStatusRefresher event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.initial));
  }

  void _onAccountFormSubmitted(AccountFormSubmitted event, Emitter<AccountAddState> emit) {
    if (isFormValid()) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      add(AccountVerified());
    } else {
      emitError(emit, TextString.formError);
    }
  }

  Future<void> _onAccountVerified(AccountVerified event, Emitter<AccountAddState> emit) async {
    try {
      //
      if(!await isAccountAlreadyUsed()) {
        final id = await _firebaseDatabase.addAccountVerification(
          AccountVerify(
            dataVerifier: dataInterpolation(),
            timeStamp: DateTime.now()
          )
        );
        //
        if (id != null && id.isNotEmpty) {
          add(AccountVerifyReplyFetched(id));
        } else {
          emitError(emit, TextString.error);
        }
      }
    } catch (e) {
      emitError(emit, e.toString());
    }
  }

  void _onAccountVerifyReplyFetched(AccountVerifyReplyFetched event, Emitter<AccountAddState> emit) {
    _streamSubscription?.cancel();
    _streamSubscription = _firebaseDatabase.getSignupVerifyReply(event.id)
    .listen((accountVerify) {
      add(AccountVerifyReplyUpdated(accountVerify));
    });
  }

  Future<void> _onAccountVerifyReplyUpdated(AccountVerifyReplyUpdated event, Emitter<AccountAddState> emit) async {
    if (event.accountVerify.isNotEmpty) {
      //
      if (isAccountExists(event.accountVerify)) {
        //
        try {
          final String request = 'add_account|${state.accountNumber.value}|${state.firstName.value}';
          final id = await _firebaseDatabase.addUserRequest(
            UserRequest(
              dataRequest: request,
              extraData: '',
              ownerId: FirebaseAuth.instance.currentUser!.uid,
              timeStamp: DateTime.now(),
            )
          );
          if (id != null) {
            emit(state.copyWith(formStatus: FormzSubmissionStatus.success, message: TextString.accountAddSuccess)); 
          } else {
            emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: TextString.accountAddFailure));
          }
        } catch (e) {
          emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.toString()));
        }
      } else {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: TextString.accountNotExist));
      }
    } else {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
    }
  }
  // UTILITY METHODS ===========================================================
  // ===========================================================================

  bool isFormValid() {
    final type = state.accountType;
    final birth = state.birthdateController.text;
    //
    if (type.isUnknown || birth.isEmpty) {
      return false;
    }
    //
    if (type.isSavings) {
      return state.isValid && isBirthdateValid();
    }
    //
    return isAccountNumberValid() && isBirthdateValid();
  }

  bool isAccountNumberValid() {
    final accountNumber = state.accountNumber.value;
    final isMatch = RegExp(r'^\d{4} \d{4} \d{4} \d{4}$').hasMatch(accountNumber);
    //
    return accountNumber.isNotEmpty && isMatch;
  }
  
  bool isBirthdateValid() {
    final birthDate = state.birthdateController.text;
    final isMatch = RegExp(r'^(0[1-9]|1\d|2\d|3[01])/(0[1-9]|1[0-2])/(19[5-9]\d|20\d{2})$').hasMatch(birthDate);
    //
    return birthDate.isNotEmpty && isMatch;
  }

  Future<bool> isAccountAlreadyUsed() async {
    final account = state.accountNumber.value.replaceAll(RegExp(r'\s+'), '');
    return await _firebaseDatabase.isAccountUsed(account);
  }

  String dataInterpolation() {
    final type = state.accountType;
    final savings = type.isSavings;
    final accnt = state.accountNumber.value.replaceAll(RegExp(r'\s+'), '');
    final fName = savings ? '|${state.firstName.value.trim()}' : '';
    final lName = savings ? ',${state.lastName.value.trim()}' : '';
    final bdate = state.birthdateController.text.trim();
    //
    return '${type.name}|$accnt$fName$lName|$bdate';
  }

  void emitError(Emitter<AccountAddState> emit, String message) {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: message));
    emit(state.copyWith(formStatus: FormzSubmissionStatus.initial));
  }

  bool isAccountExists(AccountVerify accountVerify) {
    return accountVerify.dataVerifier == 'exist'; // this must be encrypted
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    state.birthdateController.dispose();
    return super.close();
  }
}
