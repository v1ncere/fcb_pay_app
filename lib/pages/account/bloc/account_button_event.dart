part of 'account_button_bloc.dart';

sealed class AccountButtonEvent extends Equatable {
  const AccountButtonEvent();

  @override
  List<Object> get props => [];
}

final class WidgetsFetched extends AccountButtonEvent {
  const WidgetsFetched(this.type);
  final String type;

  @override
  List<Object> get props => [type];
}

final class ButtonsFetched extends AccountButtonEvent {
  const ButtonsFetched(this.ids);
  final List<String> ids;

  @override
  List<Object> get props => [ids];
}