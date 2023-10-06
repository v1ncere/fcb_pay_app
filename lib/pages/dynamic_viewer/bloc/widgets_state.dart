part of 'widgets_bloc.dart';

class WidgetsState extends Equatable {
  const WidgetsState({
    this.widgetList = const <PageWidget>[],
    this.extraWidgetList = const <ExtraWidget>[],
    this.widgetStatus = Status.initial,
    this.extraWidgetStatus = Status.initial,
    this.submissionStatus = Status.initial,
    this.message
  });
  final List<PageWidget> widgetList;
  final List<ExtraWidget> extraWidgetList;
  final Status widgetStatus;
  final Status extraWidgetStatus;
  final Status submissionStatus;
  final String? message;

  WidgetsState copyWith({
    List<PageWidget>? widgetList,
    List<ExtraWidget>? extraWidgetList,
    Status? widgetStatus,
    Status? extraWidgetStatus,
    Status? submissionStatus,
    String? message
  }) {
    return WidgetsState(
      widgetList: widgetList ?? this.widgetList,
      widgetStatus: widgetStatus ?? this.widgetStatus,
      extraWidgetList: extraWidgetList ?? this.extraWidgetList,
      extraWidgetStatus: extraWidgetStatus ?? this.extraWidgetStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [
    widgetList,
    extraWidgetList,
    widgetStatus,
    extraWidgetStatus,
    submissionStatus
  ];
}