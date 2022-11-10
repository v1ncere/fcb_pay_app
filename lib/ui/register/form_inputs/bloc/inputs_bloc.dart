import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/repository/authentication_repository/authentication_repository.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/account/account_barrel.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/address/address_barrel.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/mobile_number/models/mobile_number.dart';
import 'package:formz/formz.dart';

part 'inputs_event.dart';
part 'inputs_state.dart';

class InputsBloc extends Bloc<InputsEvent, InputsState> {
  final AuthenticationRepository authenticationRepository;
  InputsBloc({required this.authenticationRepository}) : super(const InputsState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmedPasswordChanged>(_onConfirmedPasswordChanged);
    on<HomeAddressChanged>(_onHomeAddressChanged);
    on<PostCodeChanged>(_onPostCodeChanged);
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
        state.confirmedPassword
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
        state.confirmedPassword
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
        confirmedPassword
      ]),
    ));
  }

  void _onHomeAddressChanged(HomeAddressChanged event, Emitter<InputsState> emit) {
    final homeAddress = HomeAddress.dirty(event.homeAddress);
    emit(state.copyWith(
      homeAddress: homeAddress,
      status: Formz.validate([
        homeAddress,
        state.postCode,
      ]),
    ));
  }

  void _onPostCodeChanged(PostCodeChanged event, Emitter<InputsState> emit) {
    final postCode = PostCode.dirty(event.postCode);
    emit(state.copyWith(
      postCode: postCode,
      status: Formz.validate([
        state.homeAddress,
        postCode,
      ]),
    ));
  }

  void _onMobileNumberChanged(MobileNumberChanged event, Emitter<InputsState> emit) {
    final mobileNumber = MobileNumber.dirty(event.mobileNumber);
    emit(state.copyWith(
      mobileNumber: mobileNumber,
      status: Formz.validate([
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
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
    }
  }
}
