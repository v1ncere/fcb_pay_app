import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/repository/authentication_repository/authentication_repository.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/form_inputs.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/logic/mobile_number.dart';
import 'package:formz/formz.dart';

import '../form_inputs/account/models/model_barrel.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authenticationRepository) : super(const RegisterState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
        state.mobileNumber,
        state.postalCode,
        state.address,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          password,
          confirmedPassword,
          state.mobileNumber,
          state.postalCode,
          state.address,
        ]),
      )
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([ 
          state.email,
          state.password,
          confirmedPassword,
          state.mobileNumber,
          state.postalCode,
          state.address,
        ]),
      ),
    );
  }

  void mobileChanged(String value) {
    final mobile = MobileNumber.dirty(value);
    emit(state.copyWith(
      mobileNumber: mobile,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        mobile,
        state.postalCode,
        state.address,
      ]),
    ));
  }

  void postalCodeChanged(String value) {
    final postalCode = Number.dirty(value);
    emit(state.copyWith(
      postalCode: postalCode,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        state.mobileNumber,
        postalCode,
        state.address,
      ]),
    ));
  }

  void addressChanged(String value) {
    final address = Letter.dirty(value);
    emit(state.copyWith(
      address: address,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        state.mobileNumber,
        state.postalCode,
        address,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if(!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value, 
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        )
      );
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
