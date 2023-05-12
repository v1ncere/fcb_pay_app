import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_selection_dropdown_event.dart';
part 'payment_selection_dropdown_state.dart';

class PaymentSelectionDropdownBloc extends Bloc<PaymentSelectionDropdownEvent, PaymentSelectionDropdownState> {
  PaymentSelectionDropdownBloc({
        required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }): _realtimeDBRepository = firebaseRealtimeDBRepository,
    super(const PaymentSelectionDropdownState()) {
    on<PaymentInstitutionLoaded>(_onPaymentInstitutionLoaded);
    on<PaymentInstitutionUpdated>(_onPaymentInstitutionUpdated);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  StreamSubscription<List<Institution>>? _streamSubscription;

  void _onPaymentInstitutionLoaded(
    PaymentInstitutionLoaded event,
    Emitter<PaymentSelectionDropdownState> emit
  ) async {
    emit(state.copyWith(status: PaymentSelectionDropdownStatus.progress));
    _streamSubscription = _realtimeDBRepository.getInstitutionList()
    .listen((event){
      add(PaymentInstitutionUpdated(event));
    });
  }

  void _onPaymentInstitutionUpdated(
    PaymentInstitutionUpdated event,
    Emitter<PaymentSelectionDropdownState> emit
  ) async {
    if (event.institution.isNotEmpty) {
      emit(
        state.copyWith(
          status: PaymentSelectionDropdownStatus.success,
          institution: event.institution,
        )
      );
    } else {
      emit(
        state.copyWith(
          status: PaymentSelectionDropdownStatus.failure,
          error: 'Empty',
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel;
    return super.close();
  }
}
