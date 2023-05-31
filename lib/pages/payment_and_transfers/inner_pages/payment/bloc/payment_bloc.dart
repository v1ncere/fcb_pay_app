import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository
  }) : _firebaseRealtimeDBRepository = firebaseRealtimeDBRepository, 
  super(const PaymentState()) {
    on<PaymentTransactionAmountChanged>(_onPaymentTransactionAmountChanged);
    on<InstitutionValueChanged>(_onInstitutionSelectionChanged);
    on<AccountValueChanged>(_onAccountSelectionChanged);
    on<PaymentSubmitted>(_onPaymentSubmitted);
  }
  final FirebaseRealtimeDBRepository _firebaseRealtimeDBRepository;

  void _onPaymentTransactionAmountChanged(
    PaymentTransactionAmountChanged event,
    Emitter<PaymentState> emit
  ) {
    final amount = Amount.dirty(event.amount);
    emit(state.copyWith(amount: amount));
  }

  void _onInstitutionSelectionChanged(
    InstitutionValueChanged event,
    Emitter<PaymentState> emit
  ) {
    final institutionDropdown = InstitutionDropdown.dirty(event.institution);
    emit(state.copyWith(institutionDropdown: institutionDropdown));
  }

  void _onAccountSelectionChanged(
    AccountValueChanged event,
    Emitter<PaymentState> emit
  ) {
    final accountDropdown = AccountDropdown.dirty(event.account);
    emit(state.copyWith(accountDropdown: accountDropdown));
  }

  Future<void> _onPaymentSubmitted(
    PaymentSubmitted event,
    Emitter<PaymentState> emit
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _firebaseRealtimeDBRepository.addUserAccount(
          UserRequest(
            dataRequest: 'bills_payment|${state.accountDropdown.value}|${state.institutionDropdown.value}|${state.amount.value}',
            ownerId: FirebaseAuth.instance.currentUser!.uid,
            timeStamp: DateTime.now(),
          )
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            error: e.toString(),
            status: FormzSubmissionStatus.failure
          )
        );  
      }
    }
  }
}
