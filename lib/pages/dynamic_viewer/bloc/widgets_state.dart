part of 'widgets_bloc.dart';

class WidgetsState extends Equatable {
  const WidgetsState({
    this.widgetList = const <PageWidget>[],
    this.extraWidgetList = const <ExtraWidget>[],
    this.widgetStatus = Status.initial,
    this.extraWidgetStatus = Status.initial,
    this.submissionStatus = Status.initial,
    this.message = '',
    this.dropdownHasData = true,
    //
    this.pin = const Pin.pure(),
    this.verificationId = '',
    this.resendToken,
    this.otpStatus = FormzSubmissionStatus.initial
  });
  final List<PageWidget> widgetList;
  final List<ExtraWidget> extraWidgetList;
  final Status widgetStatus;
  final Status extraWidgetStatus;
  final Status submissionStatus;
  final String message;
  final bool dropdownHasData;
  // 
  final Pin pin;
  final String verificationId;
  final int? resendToken;
  final FormzSubmissionStatus otpStatus;

  WidgetsState copyWith({
    List<PageWidget>? widgetList,
    List<ExtraWidget>? extraWidgetList,
    Status? widgetStatus,
    Status? extraWidgetStatus,
    Status? submissionStatus,
    String? message,
    bool? dropdownHasData,
    //
    Pin? pin,
    String? verificationId,
    int? resendToken,
    FormzSubmissionStatus? otpStatus
  }) {
    return WidgetsState(
      widgetList: widgetList ?? this.widgetList,
      widgetStatus: widgetStatus ?? this.widgetStatus,
      extraWidgetList: extraWidgetList ?? this.extraWidgetList,
      extraWidgetStatus: extraWidgetStatus ?? this.extraWidgetStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      message: message ?? this.message,
      dropdownHasData: dropdownHasData ?? this.dropdownHasData,
      //
      pin: pin ?? this.pin,
      verificationId: verificationId ?? this.verificationId,
      resendToken: resendToken ?? this.resendToken,
      otpStatus: otpStatus ?? this.otpStatus
    );
  }
  
  @override
  List<Object?> get props => [
    widgetList,
    extraWidgetList,
    widgetStatus,
    extraWidgetStatus,
    submissionStatus,
    dropdownHasData,
    //
    pin,
    verificationId,
    resendToken,
    otpStatus
  ];
}