import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'account_register_event.dart';
part 'account_register_state.dart';

class AccountRegisterBloc extends Bloc<AccountRegisterEvent, AccountRegisterState> {
  AccountRegisterBloc({
    required FirebaseRealtimeDBRepository firebaseDatabaseService,
  }): _firebaseDatabaseService = firebaseDatabaseService, 
      super(const AccountRegisterState()) {
        on<AccountNumberChanged>(_onAccountNumberChanged);
        on<AccountNameChanged>(_onAccountNameChanged);
        on<AccountFormSubmitted>(_onAccountFormSubmitted);
      }
  final FirebaseRealtimeDBRepository _firebaseDatabaseService;

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<AccountRegisterState> emit) {
    final accountNumber = AccountNumber.dirty(event.accountNumber);
    emit(state.copyWith(accountNumber: accountNumber));
  }

  void _onAccountNameChanged(AccountNameChanged event, Emitter<AccountRegisterState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(name: name));
  }

  Future<void> _onAccountFormSubmitted(AccountFormSubmitted event, Emitter<AccountRegisterState> emit) async {
    if(state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final String req = "add_account|${state.accountNumber.value}|${state.name.value}";
        await _firebaseDatabaseService.addUserAccount(
          UserRequest(
            dataRequest: req,
            ownerId: FirebaseAuth.instance.currentUser!.uid,
            timeStamp: DateTime.now(),
          )
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
