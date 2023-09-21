import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _dbRepository = firebaseRealtimeDBRepository,
   super(const DropdownState(status: Status.loading)) {
    on<DropdownFetched>((event, emit) async {
      try {
        List<String> dropdownList = [];
        dropdownList = await _dbRepository.getDynamicDropdownData(event.reference);

        emit(state.copyWith(status: Status.success, dropdowns: dropdownList));
      } catch (err) {
        emit(state.copyWith(status: Status.error, error: err.toString()));
      }
    });
  }
  final FirebaseRealtimeDBRepository _dbRepository;
}
