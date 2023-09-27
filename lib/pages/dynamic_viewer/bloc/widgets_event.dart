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

final class ButtonSubmitted extends WidgetsEvent {
  const ButtonSubmitted(this.title);
  final String title;

  @override
  List<Object> get props => [title];
}