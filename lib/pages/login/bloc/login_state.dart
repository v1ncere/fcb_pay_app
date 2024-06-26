part of 'login_bloc.dart';

class LoginState extends Equatable with FormzMixin {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.mobile = const MobileNumber.pure(),
    this.otp = const Pin.pure(),
    this.verificationId = '',
    this.resendToken,
    this.status = FormzSubmissionStatus.initial,
    this.otpEnabled = false,
    this.isGetOtpTapped = false,
    this.timerDisplay = '',
    this.loginOption = LoginOption.email,
    this.isObscure = true,
    this.message = ''
  });
  final Email email;
  final Password password;
  final MobileNumber mobile;
  final Pin otp;
  final String verificationId;
  final int? resendToken;
  final FormzSubmissionStatus status;
  final bool otpEnabled;
  final bool isGetOtpTapped;
  final String timerDisplay;
  final LoginOption loginOption;
  final bool isObscure;
  final String message;
  
  LoginState copyWith({
    Email? email,
    Password? password,
    MobileNumber? mobile,
    Pin? otp,
    String? verificationId,
    int? resendToken,
    FormzSubmissionStatus? status,
    bool? otpEnabled,
    bool? isGetOtpTapped,
    String? timerDisplay,
    LoginOption? loginOption,
    bool? isObscure,
    String? message
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      mobile: mobile ?? this.mobile,
      otp: otp ?? this.otp,
      verificationId: verificationId ?? this.verificationId,
      resendToken: resendToken ?? this.resendToken,
      status: status ?? this.status,
      otpEnabled: otpEnabled ?? this.otpEnabled,
      isGetOtpTapped: isGetOtpTapped ?? this.isGetOtpTapped,
      timerDisplay: timerDisplay ?? this.timerDisplay,
      loginOption: loginOption ?? this.loginOption,
      isObscure: isObscure ?? this.isObscure,
      message: message ?? this.message
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    mobile,
    otp,
    verificationId,
    resendToken,
    status,
    otpEnabled,
    isGetOtpTapped,
    timerDisplay,
    loginOption,
    isObscure,
    message,
    isValid
  ];
  
  @override
  List<FormzInput> get inputs => [email, password];
}

enum LoginOption { email, phone, google }

extension LoginOptionX on LoginOption {
  bool get isEmail => this == LoginOption.email;
  bool get isPhone => this == LoginOption.phone;
  bool get isGoogle => this == LoginOption.google;
}
