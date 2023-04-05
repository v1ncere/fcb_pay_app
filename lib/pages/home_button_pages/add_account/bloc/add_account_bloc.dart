import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/repository/repository.dart';

part 'add_account_event.dart';
part 'add_account_state.dart';

class AddAccountBloc extends Bloc<AddAccountEvent, AddAccountState> {
  AddAccountBloc({
    required FirebaseDatabaseService firebaseDatabaseService,
  }): _firebaseDatabaseService = firebaseDatabaseService, 
      super(const AddAccountState()) {
        on<AccountNumberChanged>(_onAccountNumberChanged);
        on<AccountFormSubmitted>(_onAccountFormSubmitted);
      }
  final FirebaseDatabaseService _firebaseDatabaseService;

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<AddAccountState> emit) {
    final accountNumber = AccountNumber.dirty(event.accountNumber);
    emit(state.copyWith(accountNumber: accountNumber));
  }

  Future<void> _onAccountFormSubmitted(AccountFormSubmitted event, Emitter<AddAccountState> emit) async {
    if(state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _firebaseDatabaseService.addUserAccount(UserRequest(
          dataRequest: state.accountNumber.value,
          ownerId: FirebaseAuth.instance.currentUser!.uid,
          timeStamp: DateTime.now(),
        ));
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
