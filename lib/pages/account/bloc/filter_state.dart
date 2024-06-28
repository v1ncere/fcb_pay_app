part of 'filter_bloc.dart';

class FilterState extends Equatable {
  const FilterState({
    this.filters = const [],
    this.filterStatus = Status.initial,
    this.message = ''
  });
  final List<String> filters;
  final Status filterStatus;
  final String message;

  FilterState copyWith({
    List<String>? filters,
    Status? filterStatus,
    String? message
  }) {
    return FilterState(
      filters: filters ?? this.filters,
      filterStatus: filterStatus ?? this.filterStatus,
      message: message ?? this.message
    );
  }

  @override
  List<Object> get props => [filters, filterStatus, message];
}
