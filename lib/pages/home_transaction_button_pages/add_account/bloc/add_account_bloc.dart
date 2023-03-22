import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/register/register.dart';
import 'package:fcb_pay_app/repository/repository.dart';

part 'add_account_event.dart';
part 'add_account_state.dart';

class AddAccountBloc extends Bloc<AddAccountEvent, AddAccountState> {
  final HiveAccountService accountHiveRepository;
  AddAccountBloc({required this.accountHiveRepository})
    : super(const AddAccountState()) {
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<AccountFormSubmitted>(_onAccountFormSubmitted);
  }

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<AddAccountState> emit) {
    final accountNumber = AccountNumber.dirty(event.accountNumber);
    emit(state.copyWith(
      accountNumber: accountNumber,
      status: Formz.validate([
        accountNumber,
      ]),
    ));
  }
  void _onAccountFormSubmitted(AccountFormSubmitted event, Emitter<AddAccountState> emit) async {
    if(state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await accountHiveRepository.addAccount(Account(
          userID: FirebaseAuth.instance.currentUser!.uid,
          account: int.parse(state.accountNumber.value.replaceAll(" ", "").toString()),
          balance: 0,
          walletBalance: 0,
        ));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
