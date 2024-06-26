part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class EmailChanged extends SignUpEvent {
  const EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class FirstNameChanged extends SignUpEvent {
  const FirstNameChanged(this.firstName);
  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class LastNameChanged extends SignUpEvent {
  const LastNameChanged(this.lastName);
  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class MobileNumberChanged extends SignUpEvent {
  const MobileNumberChanged(this.mobile);
  final String mobile;

  @override
  List<Object> get props => [mobile];
}

final class PasswordChanged extends SignUpEvent {
  const PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

final class ConfirmPasswordChanged extends SignUpEvent {
  const ConfirmPasswordChanged({
    required this.confirmPassword,
    required this.password
  });
  final String confirmPassword;
  final String password;

  @override
  List<Object> get props => [confirmPassword, password];
}

final class UserImageChanged extends SignUpEvent {
  const UserImageChanged(this.image);
  final XFile image;

  @override
  List<Object> get props => [image];
}

final class EmailTextErased extends SignUpEvent {}

final class FirstNameTextErased extends SignUpEvent {}

final class LastNameTextErased extends SignUpEvent {}

final class MobileTextErased extends SignUpEvent {}

final class PasswordTextErased extends SignUpEvent {}

final class ConfirmPasswordTextErased extends SignUpEvent {}

final class PasswordObscured extends SignUpEvent {}

final class ConfirmPasswordObscured extends SignUpEvent {}

final class LostDataRetrieved extends SignUpEvent {}

// OTP EVENTS ===================================
final class OtpTextChanged extends SignUpEvent {
  const OtpTextChanged(this.pin);
  final String pin;

  @override
  List<Object> get props => [pin];
}

final class PhoneNumberSent extends SignUpEvent {
  const PhoneNumberSent(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

final class PhoneOtpSent extends SignUpEvent {
  const PhoneOtpSent({
    required this.verificationId,
    required this.resendToken
  });
  final String verificationId;
  final int? resendToken;

  @override
  List<Object> get props => [verificationId, resendToken!];
}

final class PhoneNumberResent extends SignUpEvent {
  const PhoneNumberResent();

  @override
  List<Object> get props => [];
}

final class OtpVerified extends SignUpEvent {
  const OtpVerified({
    required this.smsCode,
    required this.verificationId
  });
  final String smsCode;
  final String verificationId;

  @override
  List<Object> get props => [smsCode, verificationId];
}

final class PhoneAuthVerificationCompleted extends SignUpEvent {
  const PhoneAuthVerificationCompleted(this.authCredential);
  final AuthCredential authCredential;

  @override
  List<Object> get props => [authCredential];
}

final class PhoneAuthFailed extends SignUpEvent {
  const PhoneAuthFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class FormSubmissionFailed extends SignUpEvent {
  const FormSubmissionFailed(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

final class UserDetailsAdded extends SignUpEvent {
  const UserDetailsAdded(this.url);
  final String url;
  
  @override
  List<Object> get props => [url];
}

final class UploadImageProgressed extends SignUpEvent {
  const UploadImageProgressed(this.progress);
  final double progress;

  @override
  List<Object> get props => [progress];
}

final class FormSubmitted extends SignUpEvent {}

final class HydrateStateChanged extends SignUpEvent {
  const HydrateStateChanged({required this.isHydrated});
  final bool isHydrated;

  @override
  List<Object> get props => [isHydrated];
}
