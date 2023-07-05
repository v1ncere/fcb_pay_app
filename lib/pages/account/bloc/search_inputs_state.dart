part of 'search_inputs_bloc.dart';

class SearchInputsState extends Equatable {
  const SearchInputsState({
    this.filterType = const FilterDropdown.pure(),
    this.searchQuery = const Search.pure(),
    this.status = FormzSubmissionStatus.initial
  });
  final Search searchQuery;
  final FilterDropdown filterType;
  final FormzSubmissionStatus status;

  SearchInputsState copyWith({
    Search? searchQuery,
    FilterDropdown? filterType,
    FormzSubmissionStatus? status
  }) {
    return SearchInputsState(
      searchQuery: searchQuery ?? this.searchQuery,
      filterType: filterType ?? this.filterType,
      status: status ?? this.status
    );
  }
  
  @override
  List<Object> get props => [searchQuery, filterType, status];
}
