part of 'dropdown_bloc.dart';

class DropdownState extends Equatable {
  const DropdownState({
    this.dropdowns = const [],
    this.status = Status.initial,
    this.error = ''
  });
  final List<String> dropdowns;
  final Status status;
  final String error;

  DropdownState copyWith({
    List<String>? dropdowns,
    Status? status,
    String? error
  }) {
    return DropdownState(
      dropdowns: dropdowns ?? this.dropdowns,
      status: status ?? this.status,
      error: error ?? this.error
    );
  }

  @override
  List<Object> get props => [dropdowns, status, error];
}
