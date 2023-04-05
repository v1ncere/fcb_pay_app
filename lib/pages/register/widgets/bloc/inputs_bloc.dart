import 'package:equatable/equatable.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'inputs_event.dart';
part 'inputs_state.dart';

class InputsBloc extends Bloc<InputsEvent, InputsState> {
  final FirebaseAuthRepository _firebaseAuthService;
  InputsBloc({
    required FirebaseAuthRepository firebaseAuthService
  }) : _firebaseAuthService = firebaseAuthService, super(const InputsState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmedPasswordChanged>(_onConfirmedPasswordChanged);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<InputsState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email,));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<InputsState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  void _onConfirmedPasswordChanged(ConfirmedPasswordChanged event, Emitter<InputsState> emit) {
    final confirmedPassword = ConfirmedPassword.dirty(password: event.password, value: event.confirmPassword);
    emit(state.copyWith(confirmedPassword: confirmedPassword));
  }

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<InputsState> emit) {
    final postCode = AccountNumber.dirty(event.accountNumber);
    emit(state.copyWith(accountNumber: postCode));
  }

  void _onMobileNumberChanged(MobileNumberChanged event, Emitter<InputsState> emit) {
    final mobileNumber = MobileNumber.dirty(event.mobileNumber);
    emit(state.copyWith(mobileNumber: mobileNumber));
  }

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<InputsState> emit) async {
    if(state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _firebaseAuthService.signUp(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
