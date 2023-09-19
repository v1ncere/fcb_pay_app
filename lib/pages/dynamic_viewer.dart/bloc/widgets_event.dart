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
  final List<HomeButtonWidget> widgetList;

  @override
  List<Object> get props => [widgetList];
}