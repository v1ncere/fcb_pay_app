import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'institution_display_event.dart';
part 'institution_display_state.dart';

class InstitutionDisplayBloc extends Bloc<InstitutionDisplayEvent, InstitutionDisplayState> {
  InstitutionDisplayBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _dbRepository = firebaseRealtimeDBRepository,
  super(const InstitutionDisplayState(status: Status.loading)) {
    on<InstitutionDisplayLoaded>(_onInstitutionDisplayLoaded);
    on<InstitutionDisplayUpdated>(_onInstitutionDisplayUpdated);
  }
  final FirebaseRealtimeDBRepository _dbRepository;
  StreamSubscription<List<Institutions>>? _subscription;

  void _onInstitutionDisplayLoaded(InstitutionDisplayLoaded event, Emitter<InstitutionDisplayState> emit) async {
    _subscription?.cancel;
    _subscription = _dbRepository
    .getInstitutionListStream()
    .listen((event) {
      add(InstitutionDisplayUpdated(event));
    });
  }

  void _onInstitutionDisplayUpdated(InstitutionDisplayUpdated event, Emitter<InstitutionDisplayState> emit) async {
    if (event.institutions.isNotEmpty) {
      emit(state.copyWith(
        institution: event.institutions,
        status: Status.success
      ));
    } else {
      emit(state.copyWith(
        error: 'Empty',
        status: Status.error
      ));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel;
    return super.close();
  }
}
