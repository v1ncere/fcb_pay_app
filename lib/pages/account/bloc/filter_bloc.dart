import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _dbRepository = firebaseRepository,
  super(const FilterState(status: Status.loading)) {
    on<FilterFetched>((event, emit) async {
      try {
        List<String> filterList = [];
        filterList = await _dbRepository.getDynamicDropdownData('filter');
        emit(state.copyWith(
          status: Status.success,
          filters: filterList
        ));
      } catch (err) {
        emit(state.copyWith(
          status: Status.error,
          error: err.toString()
        ));
      }
    });
  }
  final FirebaseRealtimeDBRepository _dbRepository;
}
