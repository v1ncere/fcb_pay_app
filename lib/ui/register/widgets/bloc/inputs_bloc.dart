import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/repository/authentication_repository/authentication_repository.dart';
import 'package:fcb_pay_app/ui/register/register.dart';

part 'inputs_event.dart';
part 'inputs_state.dart';

class InputsBloc extends Bloc<InputsEvent, InputsState> {
  final AuthenticationRepository authenticationRepository;
  InputsBloc({required this.authenticationRepository})
    : super(const InputsState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmedPasswordChanged>(_onConfirmedPasswordChanged);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<InputsState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
        state.accountNumber,
        state.mobileNumber,
      ]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<InputsState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.email,
        password,
        state.confirmedPassword,
        state.accountNumber,
        state.mobileNumber,
      ]),
    ));
  }

  void _onConfirmedPasswordChanged(ConfirmedPasswordChanged event, Emitter<InputsState> emit) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: event.password,
      value: event.confirmPassword,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
        state.accountNumber,
        state.mobileNumber,
      ]),
    ));
  }

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<InputsState> emit) {
    final postCode = AccountNumber.dirty(event.accountNumber);
    emit(state.copyWith(
      accountNumber: postCode,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        postCode,
        state.mobileNumber,
      ]),
    ));
  }

  void _onMobileNumberChanged(MobileNumberChanged event, Emitter<InputsState> emit) {
    final mobileNumber = MobileNumber.dirty(event.mobileNumber);
    emit(state.copyWith(
      mobileNumber: mobileNumber,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        state.accountNumber,
        mobileNumber,
      ]),
    ));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<InputsState> emit) async {
    if(state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await authenticationRepository.signUp(
          email: state.email.value,
          password: state.password.value,
          accountNumber: state.accountNumber.value.replaceAll(" ", "").toString(),
          balance: 0,
          walletBalance: 0,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
