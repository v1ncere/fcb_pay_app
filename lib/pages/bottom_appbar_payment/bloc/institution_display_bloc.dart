import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'institution_display_event.dart';
part 'institution_display_state.dart';

class InstitutionDisplayBloc extends Bloc<InstitutionDisplayEvent, InstitutionDisplayState> {
  InstitutionDisplayBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _realtimeDBRepository = firebaseRealtimeDBRepository,
  super(const InstitutionDisplayState()) {
    on<InstitutionDisplayLoaded>(_onPaymentInstitutionLoaded);
    on<InstitutionDisplayUpdated>(_onPaymentInstitutionUpdated);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  StreamSubscription<List<Institution>>? _streamSubscription;

  void _onPaymentInstitutionLoaded(InstitutionDisplayLoaded event, Emitter<InstitutionDisplayState> emit) async {
    emit(state.copyWith(status: InstitutionDisplayStatus.loading));
    
    _streamSubscription = _realtimeDBRepository.getInstitutionList()
    .listen((event){
      add(InstitutionDisplayUpdated(event));
    });
  }

  void _onPaymentInstitutionUpdated(InstitutionDisplayUpdated event, Emitter<InstitutionDisplayState> emit) async {
    if (event.institutions.isNotEmpty) {
      emit(state.copyWith(
        status: InstitutionDisplayStatus.success,
        institution: event.institutions
      ));
    } else {
      emit(state.copyWith(
        status: InstitutionDisplayStatus.failure,
        error: 'Empty'
      ));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel;
    return super.close();
  }
}
