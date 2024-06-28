part of 'widgets_bloc.dart';

sealed class WidgetsEvent extends Equatable {
  const WidgetsEvent();

  @override
  List<Object> get props => [];
}

final class WidgetsLoaded extends WidgetsEvent {
  const WidgetsLoaded(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class WidgetsUpdated extends WidgetsEvent {
  const WidgetsUpdated(this.widgetList);
  final List<PageWidget> widgetList;

  @override
  List<Object> get props => [widgetList];
}

final class ExtraWidgetFetched extends WidgetsEvent {
  const ExtraWidgetFetched(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class DynamicWidgetsValueChanged extends WidgetsEvent {
  const DynamicWidgetsValueChanged({
    required this.keyId,
    required this.title,
    required this.value,
    required this.type
  });
  final String keyId;
  final String title;
  final String value;
  final String type;

  @override
  List<Object> get props => [keyId, title, value, type];
}

final class ExtraWidgetsValueChanged extends WidgetsEvent {
  const ExtraWidgetsValueChanged({
    required this.keyId,
    required this.title,
    required this.value,
    required this.type
  });
  final String keyId;
  final String title;
  final String value;
  final String type;

  @override
  List<Object> get props => [keyId, title, value, type];
}

// ==================================== OTP EVENTS
final class OtpTextChanged extends WidgetsEvent {
  const OtpTextChanged(this.pin);
  final String pin;

  @override
  List<Object> get props => [pin];
}

final class PhoneNumberSent extends WidgetsEvent {
  const PhoneNumberSent(this.buttonTitle);
  final String buttonTitle;

  @override
  List<Object> get props => [buttonTitle];
}

final class PhoneOtpSent extends WidgetsEvent {
  const PhoneOtpSent({
    required this.verificationId,
    required this.resendToken
  });
  final String verificationId;
  final int? resendToken;

  @override
  List<Object> get props => [verificationId, resendToken!];
}

final class PhoneNumberResent extends WidgetsEvent {}

final class OtpVerified extends WidgetsEvent {}

final class PhoneAuthVerificationCompleted extends WidgetsEvent {
  const PhoneAuthVerificationCompleted(this.authCredential);
  final AuthCredential authCredential;

  @override
  List<Object> get props => [authCredential];
}

final class PhoneAuthFailed extends WidgetsEvent {
  const PhoneAuthFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
// ======================================== OTP EVENTS END

final class ButtonSubmitted extends WidgetsEvent {
  const ButtonSubmitted(this.title);
  final String title;

  @override
  List<Object> get props => [title];
}