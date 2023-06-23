part of 'search_inputs_bloc.dart';

abstract class SearchInputsEvent extends Equatable {
  const SearchInputsEvent();

  @override
  List<Object> get props => [];
}

class SearchTextFieldChanged extends SearchInputsEvent {
  const SearchTextFieldChanged(this.searchQuery);
  final String searchQuery;

  @override
  List<Object> get props => [searchQuery];
}

class FilterDropdownChanged extends SearchInputsEvent {
  const FilterDropdownChanged(this.filterType);
  final String filterType;

  @override
  List<Object> get props => [filterType];
}

class FilterSubmitted extends SearchInputsEvent {}