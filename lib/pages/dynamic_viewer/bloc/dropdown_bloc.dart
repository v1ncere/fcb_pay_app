import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _firebaseRepository = firebaseRepository,
  super(const DropdownState(status: Status.loading)) {
    on<DropdownFetched>(_onDropdownFetched);
  }

  void _onDropdownFetched(DropdownFetched event, Emitter<DropdownState> emit) async {
    try {
      final dropdownList = await _firebaseRepository.getDynamicListStringData(event.reference);
      emit(state.copyWith(status: Status.success, dropdowns: dropdownList));
    } catch (err) {
      emit(state.copyWith(status: Status.error, message: err.toString()));
    }
  }

  final FirebaseRealtimeDBRepository _firebaseRepository;
}
