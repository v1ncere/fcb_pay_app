import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'institution_display_event.dart';
part 'institution_display_state.dart';

class InstitutionDisplayBloc extends Bloc<InstitutionDisplayEvent, InstitutionDisplayState> {
  InstitutionDisplayBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _dbRepository = firebaseRealtimeDBRepository,
  super(const InstitutionDisplayState()) {
    on<InstitutionDisplayLoaded>(_onInstitutionDisplayLoaded);
    on<InstitutionDisplayUpdated>(_onInstitutionDisplayUpdated);
  }
  final FirebaseRealtimeDBRepository _dbRepository;
  late final StreamSubscription<List<Institution>> _subscription;

  void _onInstitutionDisplayLoaded(InstitutionDisplayLoaded event, Emitter<InstitutionDisplayState> emit) async {
    emit(state.copyWith(status: InstitutionDisplayStatus.loading));

    _subscription = _dbRepository
    .getInstitutionList()
    .listen((event) {
      add(InstitutionDisplayUpdated(event));
    });
  }

  void _onInstitutionDisplayUpdated(InstitutionDisplayUpdated event, Emitter<InstitutionDisplayState> emit) async {
    if (event.institutions.isNotEmpty) {
      emit(state.copyWith(
        institution: event.institutions,
        status: InstitutionDisplayStatus.success
      ));
    } else {
      emit(state.copyWith(
        error: 'Empty',
        status: InstitutionDisplayStatus.error
      ));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel;
    return super.close();
  }
}
