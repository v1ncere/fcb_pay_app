import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';

part 'sign_up_verify_event.dart';
part 'sign_up_verify_state.dart';

class SignUpVerifyBloc extends Bloc<SignUpVerifyEvent, SignUpVerifyState> {
  SignUpVerifyBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository
  }) :  _firebaseRepository = firebaseRealtimeDBRepository,
  super(SignUpVerifyState(birthdateController: TextEditingController())) {
    on<AccountTypeDropdownChanged>(_onAccountTypeDropdownChanged);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthDateChanged>(_onBirthDateChanged);
    on<VerifyButtonSubmitted>(_onVerifyButtonSubmitted);
    on<AccountVerified>(_onAccountVerified);
    on<AccountVerifyReplied>(_onAccountVerifyReplied);
    on<AccountVerifyReplyUpdated>(_onAccountVerifyReplyUpdated);
  }
  final FirebaseRealtimeDBRepository _firebaseRepository;
  StreamSubscription<AccountVerify>? _streamSubscription;

  // DROPDOWN ===========================================================================================
  void _onAccountTypeDropdownChanged(AccountTypeDropdownChanged event, Emitter<SignUpVerifyState> emit) {
    emit(state.copyWith(accountType: event.accountType));
  }

  // TEXTFORMFIELDS =========================================================================
  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<SignUpVerifyState> emit) {
    final account = AccountNumber.dirty(event.account);
    emit(state.copyWith(accountNumber: account));
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<SignUpVerifyState> emit) {
    final firstName = Name.dirty(event.firstName);
    emit(state.copyWith(firstName: firstName));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<SignUpVerifyState> emit) {
    final lastName = Name.dirty(event.lastName);
    emit(state.copyWith(lastName: lastName));
  }

  void _onBirthDateChanged(BirthDateChanged event, Emitter<SignUpVerifyState> emit) {
    final dateString = DateFormat('dd/MM/yyyy').format(event.date);
    final controller = TextEditingController(text: dateString);
    emit(state.copyWith(birthdateController: controller));
  }

  // SUBMIT BUTTON ============================================================================
  void _onVerifyButtonSubmitted(VerifyButtonSubmitted event, Emitter<SignUpVerifyState> emit) {
    if (isFormValid()) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress)); // emit in progress
      add(AccountVerified());
    } else {
      emitError(emit, TextString.formError);
    }
  }

  Future<void> _onAccountVerified(AccountVerified event, Emitter<SignUpVerifyState> emit) async {
    try {
      if (!await isAccountAlreadyUsed()) {
        await _firebaseRepository.addAccountVerification(
          AccountVerify(dataVerifier: dataInterpolation(), timeStamp: DateTime.now())
        ).then((id) {
          if (id != null && id.isNotEmpty) {
            add(AccountVerifyReplied(id));
          } else {
            emitError(emit, TextString.error);
          }
        });
      } else {
        emitError(emit, TextString.accountAlreadyLinked);
      }
    } catch (e) {
      emitError(emit, e.toString());
    }
  }

  void _onAccountVerifyReplied(AccountVerifyReplied event, Emitter<SignUpVerifyState> emit) {
    _streamSubscription?.cancel();
    _streamSubscription = _firebaseRepository.getSignupVerifyReply(event.id)
    .listen((accountVerify) {
      add(AccountVerifyReplyUpdated(accountVerify));
    });
  }

  void _onAccountVerifyReplyUpdated(AccountVerifyReplyUpdated event, Emitter<SignUpVerifyState> emit) {
    if (event.accountVerify.isNotEmpty) {
      if (isAccountExists(event.accountVerify)) {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.success, accountVerify: event.accountVerify));
      } else {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: TextString.accountNotExist));
      }
    } else {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
    }
  }

  // UTILITY METHODS ===========================
  // ===========================================

  bool isFormValid() {
    final type = state.accountType;
    final birth = state.birthdateController.text;

    if(type.isUnknown || birth.isEmpty) {
      return false;
    }

    if(type.isSavings) {
      return state.isValid && isBirthdateValid();
    }

    return isAccountNumberValid() && isBirthdateValid();
  }

  bool isAccountNumberValid() {
    final accountNumber = state.accountNumber.value;
    final isMatch = RegExp(r'^\d{4} \d{4} \d{4} \d{4}$').hasMatch(accountNumber);
    return accountNumber.isNotEmpty && isMatch;
  }
  
  bool isBirthdateValid() {
    final birthDate = state.birthdateController.text;
    final isMatch = RegExp(r'^(0[1-9]|1\d|2\d|3[01])/(0[1-9]|1[0-2])/(19[5-9]\d|20\d{2})$').hasMatch(birthDate);
    return birthDate.isNotEmpty && isMatch;
  }

  Future<bool> isAccountAlreadyUsed() async {
    final account = state.accountNumber.value.replaceAll(RegExp(r'\s+'), '');
    return await _firebaseRepository.isAccountUsed(account);
  }

  String dataInterpolation() {
    final type = state.accountType;
    final savings = type.isSavings;
    final accnt = state.accountNumber.value.replaceAll(RegExp(r'\s+'), '');
    final fName = savings ? '|${state.firstName.value.trim()}' : '';
    final lName = savings ? ',${state.lastName.value.trim()}' : '';
    final bdate = state.birthdateController.text.trim();

    return '${type.name}|$accnt$fName$lName|$bdate';
  }

  void emitError(Emitter<SignUpVerifyState> emit, String message) {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: message));
    emit(state.copyWith(formStatus: FormzSubmissionStatus.initial));
  }

  bool isAccountExists(AccountVerify accountVerify) {
    return accountVerify.dataVerifier == 'exist'; // this must be encrypted
  }

  //
  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    state.birthdateController.dispose();
    return super.close();
  }
}
