part of 'widgets_bloc.dart';

class WidgetsState extends Equatable {
  const WidgetsState({
    this.widgetList = const <HomeButtonWidget>[],
    this.status = Status.initial,
    this.errorMsg
  });
  final List<HomeButtonWidget> widgetList;
  final Status status;
  final String? errorMsg;

  WidgetsState copyWith({
    List<HomeButtonWidget>? widgetList,
    Status? status,
    String? errorMsg
  }) {
    return WidgetsState(
      widgetList: widgetList ?? this.widgetList,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg
    );
  }
  
  @override
  List<Object> get props => [widgetList, status];
}