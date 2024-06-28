part of 'sign_up_bloc.dart';

class SignUpState extends Equatable with FormzMixin {
  const SignUpState({
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.mobileController,
    required this.passwordController,
    required this.confirmPasswordController,
    //
    this.email = const Email.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.mobile = const MobileNumber.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmedPassword.pure(),
    this.userImage,
    this.pin = const Pin.pure(),
    this.verificationId = '',
    this.resendToken,
    //
    this.userImageStatus = Status.initial,
    this.otpStatus = FormzSubmissionStatus.initial,
    this.formStatus = FormzSubmissionStatus.initial,
    //
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    //
    this.message = '',
    this.progress = 0.0,
    this.hydratedStatus = false,
  });
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mobileController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  //
  final Email email;
  final Name firstName;
  final Name lastName;
  final MobileNumber mobile;
  final Password password;
  final ConfirmedPassword confirmPassword;
  final XFile? userImage;
  final Pin pin;
  final String verificationId;
  final int? resendToken;
  //
  final Status userImageStatus;
  final FormzSubmissionStatus otpStatus;
  final FormzSubmissionStatus formStatus;
  //
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  //
  final String message;
  final double progress;
  final bool hydratedStatus;
  
  SignUpState copyWith({
    TextEditingController? emailController,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? mobileController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    //
    Email? email,
    Name? firstName,
    Name? lastName,
    MobileNumber? mobile,
    Password? password,
    ConfirmedPassword? confirmPassword,
    XFile? userImage,
    Pin? pin,
    String? verificationId,
    int? resendToken,
    //
    Status? userImageStatus,
    FormzSubmissionStatus? otpStatus,
    FormzSubmissionStatus? formStatus,
    //
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    //
    String? message,
    double? progress,
    bool? hydratedStatus,
  }) {
    return SignUpState(
      emailController: emailController ?? this.emailController,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      mobileController: mobileController ?? this.mobileController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
      //
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      userImage: userImage ?? this.userImage,
      pin: pin ?? this.pin,
      verificationId: verificationId ?? this.verificationId,
      resendToken: resendToken ?? this.resendToken,
      //
      userImageStatus: userImageStatus ?? this.userImageStatus,
      otpStatus: otpStatus ?? this.otpStatus,
      formStatus: formStatus ?? this.formStatus,
      //
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      //
      message: message ?? this.message,
      progress: progress ?? this.progress,
      hydratedStatus: hydratedStatus ?? this.hydratedStatus
    );
  }
  
  @override
  List<Object?> get props => [
    emailController,
    firstNameController,
    lastNameController,
    mobileController,
    passwordController,
    confirmPasswordController,
    //
    email,
    firstName,
    lastName,
    mobile,
    password,
    confirmPassword,
    userImage,
    pin,
    verificationId,
    resendToken,
    //
    userImageStatus,
    otpStatus,
    formStatus,
    //
    obscurePassword,
    obscureConfirmPassword,
    //
    message,
    progress,
    hydratedStatus,
    //
    isValid
  ];
  
  @override
  List<FormzInput> get inputs => [
    email,
    firstName,
    lastName,
    mobile,
    password,
    confirmPassword,
    pin
  ];
}