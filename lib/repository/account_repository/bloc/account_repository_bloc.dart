import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/repository/account_repository/account_repository.dart';
import 'package:fcb_pay_app/repository/model/account.dart';

part 'account_repository_event.dart';
part 'account_repository_state.dart';

class AccountRepositoryBloc extends Bloc<AccountRepositoryEvent, AccountRepositoryState> {
  final AccountRepository _accountRepository;
  StreamSubscription? _streamSubscription;

  AccountRepositoryBloc({
    required AccountRepository accountRepository
  }) : _accountRepository = accountRepository, super(AccountLoading()) {
    on<LoadAccounts>(_loadAccounts);
    on<UpdateAccounts>(_updateAccounts);
  }

  void _loadAccounts(LoadAccounts event, Emitter<AccountRepositoryState> emit) async {
    _streamSubscription?.cancel();
    _streamSubscription = _accountRepository
    .getAllAccount()
    .listen((accounts) => add(UpdateAccounts(accounts)));
  }

  void _updateAccounts(UpdateAccounts event, Emitter<AccountRepositoryState> emit) async {
    emit(AccountLoaded(accountModel: event.accounts));
  }
}
