import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'search_inputs_event.dart';
part 'search_inputs_state.dart';

class SearchInputsBloc extends Bloc<SearchInputsEvent, SearchInputsState> {
  SearchInputsBloc() : super(const SearchInputsState()) {
    on<SearchTextFieldChanged>(_onSearchTextFieldChanged);
    on<FilterDropdownChanged>(_onFilterDropdownChanged);
    on<FilterSubmitted>(_onFilterSubmitted);
  }

  void _onSearchTextFieldChanged(SearchTextFieldChanged event, Emitter<SearchInputsState> emit) {
    final search = Search.dirty(event.searchQuery);
    emit(state.copyWith(searchQuery: search));
  }

  void _onFilterDropdownChanged(FilterDropdownChanged event, Emitter<SearchInputsState> emit) {
    final filter = FilterDropdown.dirty(event.filterType);
    emit(state.copyWith(filterType: filter));
  }

  void _onFilterSubmitted(FilterSubmitted event, Emitter<SearchInputsState> emit) {
    
  }
}
