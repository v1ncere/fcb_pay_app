import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final FirebaseRealtimeDBRepository _dbRepository;

  FilterBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _dbRepository = firebaseRepository,
  super(const FilterState(filterStatus: Status.loading)) {
    on<FilterFetched>(_onFilteredFetched);
  }

  void _onFilteredFetched(FilterFetched event, Emitter<FilterState> emit) async {
    try {
      List<String> filterList = [];
      filterList = await _dbRepository.getDynamicListStringData('filter');
      emit(state.copyWith(filterStatus: Status.success, filters: filterList));
    } catch (e) {
      emit(state.copyWith(filterStatus: Status.error, message: e.toString()));
    }
  }
}
