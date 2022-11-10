part of 'inputs_bloc.dart';

class InputsState extends Equatable {
  const InputsState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.homeAddress = const HomeAddress.pure(),
    this.postCode = const PostCode.pure(),
    this.mobileNumber = const MobileNumber.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final HomeAddress homeAddress;
  final PostCode postCode;
  final MobileNumber mobileNumber;
  final FormzStatus status;
  
  InputsState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    HomeAddress? homeAddress,
    PostCode? postCode,
    MobileNumber? mobileNumber,
    FormzStatus? status,
  }) {
    return InputsState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      homeAddress: homeAddress ?? this.homeAddress,
      postCode: postCode ?? this.postCode,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
    email,
    password,
    confirmedPassword,
    homeAddress,
    postCode,
    mobileNumber,
    status
  ];
}