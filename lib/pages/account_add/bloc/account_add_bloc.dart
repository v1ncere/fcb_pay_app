import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'account_add_event.dart';
part 'account_add_state.dart';

class AccountAddBloc extends Bloc<AccountAddEvent, AccountAddState> {
  AccountAddBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  })  : _firebaseDatabaseService = firebaseRepository, 
  super(const AccountAddState()) {
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<AccountNameChanged>(_onAccountNameChanged);
    on<AccountFormSubmitted>(_onAccountFormSubmitted);
    on<AccountStatusRefresher>(_onAccountStatusRefresher);
  }
  final FirebaseRealtimeDBRepository _firebaseDatabaseService;

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<AccountAddState> emit) {
    final accountNumber = AccountNumber.dirty(event.accountNumber);
    emit(state.copyWith(accountNumber: accountNumber));
  }

  void _onAccountNameChanged(AccountNameChanged event, Emitter<AccountAddState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(name: name));
  }

  void _onAccountStatusRefresher(AccountStatusRefresher event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.initial));
  }

  Future<void> _onAccountFormSubmitted(AccountFormSubmitted event, Emitter<AccountAddState> emit) async {
    if(state.isValid) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      try {
        final String req = "add_account|${state.accountNumber.value}|${state.name.value}";
        await _firebaseDatabaseService.addUserRequest(
          UserRequest(
            dataRequest: req,
            ownerId: FirebaseAuth.instance.currentUser!.uid,
            timeStamp: DateTime.now(),
          )
        );
        emit(state.copyWith(formStatus: FormzSubmissionStatus.success));
      } catch (err) {
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.failure,
          message: err.toString()
        ));
      }
    } else {
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.failure,
        message: "Incomplete Form: Please review the form and make sure all required fields are filled in correctly.",
      ));
    }
  }
}
