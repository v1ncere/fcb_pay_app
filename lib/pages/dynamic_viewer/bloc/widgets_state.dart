part of 'widgets_bloc.dart';

class WidgetsState extends Equatable {
  const WidgetsState({
    this.widgetList = const <PageWidget>[],
    this.widgetStatus = Status.initial,
    this.submissionStatus = Status.initial,
    this.source,
    this.errorMsg
  });
  final List<PageWidget> widgetList;
  final Status widgetStatus;
  final Status submissionStatus;
  final String? source;
  final String? errorMsg;

  WidgetsState copyWith({
    List<PageWidget>? widgetList,
    Status? widgetStatus,
    Status? submissionStatus,
    String? source,
    String? errorMsg
  }) {
    return WidgetsState(
      widgetList: widgetList ?? this.widgetList,
      widgetStatus: widgetStatus ?? this.widgetStatus,
      source: source ?? this.source,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      errorMsg: errorMsg ?? this.errorMsg
    );
  }
  
  @override
  List<Object> get props => [widgetList, widgetStatus, submissionStatus];
}