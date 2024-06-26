part of 'dropdown_bloc.dart';

class DropdownState extends Equatable {
  const DropdownState({
    this.dropdowns = const <String>[],
    this.status = Status.initial,
    this.message = ''
  });
  final List<String> dropdowns;
  final Status status;
  final String message;

  DropdownState copyWith({
    List<String>? dropdowns,
    Status? status,
    String? message,
  }) {
    return DropdownState(
      dropdowns: dropdowns ?? this.dropdowns,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [dropdowns, status, message];
}
