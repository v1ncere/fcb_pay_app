part of 'widgets_bloc.dart';

class WidgetsState extends Equatable {
  const WidgetsState({
    this.widgetList = const <HomeButtonWidget>[],
    this.widgetStatus = Status.initial,
    this.submissionStatus = Status.initial,
    this.errorMsg
  });
  final List<HomeButtonWidget> widgetList;
  final Status widgetStatus;
  final Status submissionStatus;
  final String? errorMsg;

  WidgetsState copyWith({
    List<HomeButtonWidget>? widgetList,
    Status? widgetStatus,
    Status? submissionStatus,
    String? errorMsg
  }) {
    return WidgetsState(
      widgetList: widgetList ?? this.widgetList,
      widgetStatus: widgetStatus ?? this.widgetStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      errorMsg: errorMsg ?? this.errorMsg
    );
  }
  
  @override
  List<Object> get props => [widgetList, widgetStatus, submissionStatus];
}