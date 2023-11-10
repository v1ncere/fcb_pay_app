part of 'dropdown_bloc.dart';

sealed class DropdownEvent extends Equatable {
  const DropdownEvent();

  @override
  List<Object> get props => [];
}

final class DropdownFetched extends DropdownEvent {
  const DropdownFetched(this.reference);
  final String reference;

  @override
  List<Object> get props => [reference];
}