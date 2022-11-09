import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/account/models/confirmed_password.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/account/models/email.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/account/models/password.dart';
import 'package:formz/formz.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmedPasswordChanged>(_onConfirmedPasswordChanged);
  }

  void _onEmailChanged(EmailChanged event, Emitter<AccountState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword
      ]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AccountState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.email,
        password,
        state.confirmedPassword
      ]),
    ));
  }

  void _onConfirmedPasswordChanged(ConfirmedPasswordChanged event, Emitter<AccountState> emit) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: event.password,
      value: event.confirmPassword,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword
      ]),
    ));
  }
}
