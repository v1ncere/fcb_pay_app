import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/repository/account_repository/account_repo.dart';
import 'package:fcb_pay_app/repository/model/account.dart';

part 'account_repo_event.dart';
part 'account_repo_state.dart';

class AccountRepoBloc extends Bloc<AccountRepoEvent, AccountRepoState> {
  final AccountRepository _accountRepository;
  StreamSubscription? _accountSubscription;

  AccountRepoBloc({required AccountRepository accountRepository}) 
    : _accountRepository = accountRepository, super(AccountLoading()) {
    on<LoadAccounts>(_loadAccountsEventToState);
    on<UpdateAccounts>(_updateAccountsEventToState);
  }

  void _loadAccountsEventToState(LoadAccounts event, Emitter<AccountRepoState> emit) async {
    _accountSubscription?.cancel();
    _accountSubscription = _accountRepository.getAllAccount().listen(
      (accounts) => add(UpdateAccounts(accounts))
    );
  }

  void _updateAccountsEventToState(UpdateAccounts event, Emitter<AccountRepoState> emit) async {
    emit(AccountLoaded(accountModel: event.accounts));
  }
}
