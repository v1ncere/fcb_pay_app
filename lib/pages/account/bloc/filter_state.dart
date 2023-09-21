part of 'filter_bloc.dart';

class FilterState extends Equatable {
  const FilterState({
    this.filters = const [],
    this.status = Status.initial,
    this.error = ''
  });
  final List<String> filters;
  final Status status;
  final String error;

  FilterState copyWith({
    List<String>? filters,
    Status? status,
    String? error
  }) {
    return FilterState(
      filters: filters ?? this.filters,
      status: status ?? this.status,
      error: error ?? this.error
    );
  }

  @override
  List<Object> get props => [filters, status, error];
}
