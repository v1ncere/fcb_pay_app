import 'package:equatable/equatable.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required FirebaseAuthRepository firebaseAuthRepository
  }) : _firebaseAuthRepository = firebaseAuthRepository,
  super(const RegisterState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmedPasswordChanged>(_onConfirmedPasswordChanged);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }
  final FirebaseAuthRepository _firebaseAuthRepository;

  void _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  void _onConfirmedPasswordChanged(ConfirmedPasswordChanged event, Emitter<RegisterState> emit) {
    final confirmedPassword = ConfirmedPassword.dirty(password: event.password, value: event.confirmPassword);
    emit(state.copyWith(confirmedPassword: confirmedPassword));
  }

  void _onMobileNumberChanged(MobileNumberChanged event, Emitter<RegisterState> emit) {
    final mobileNumber = MobileNumber.dirty(event.mobileNumber);
    emit(state.copyWith(mobileNumber: mobileNumber));
  }

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<RegisterState> emit) async {
    if(state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _firebaseAuthRepository.signUpWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on SignUpWithEmailAndPasswordFailure catch (e) {
        emit(
          state.copyWith(
            error: e.message,
            status: FormzSubmissionStatus.failure,
          )
        );
      } catch (e) {
        emit(
          state.copyWith(
            error: e.toString(),
            status: FormzSubmissionStatus.failure
          )
        );
      }
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        error: "Required Field(s) Missing. Please Complete All Fields."
      ));
    }
  }
}