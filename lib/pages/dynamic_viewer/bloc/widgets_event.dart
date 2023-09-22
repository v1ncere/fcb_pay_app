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

final class AdditionalTextFieldValueChanged extends WidgetsEvent {
  const AdditionalTextFieldValueChanged({
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

final class ButtonSubmitted extends WidgetsEvent {}