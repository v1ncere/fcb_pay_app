import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/repository/repository.dart';

part 'account_repository_event.dart';
part 'account_repository_state.dart';

class AccountRepositoryBloc extends Bloc<AccountRepositoryEvent, AccountRepositoryState> {
  final AccountRepository _accountRepository;
  final AccountHiveRepository _accountHiveRepository;
  StreamSubscription? _streamSubscription;

  AccountRepositoryBloc({
    required AccountRepository accountRepository,
    required AccountHiveRepository accountHiveRepository,
  }): _accountRepository = accountRepository,
      _accountHiveRepository = accountHiveRepository,
      super(AccountLoading()) {
        on<LoadAccounts>(_loadAccounts);
        on<UpdateAccounts>(_updateAccounts);
      }

  void _loadAccounts(LoadAccounts event, Emitter<AccountRepositoryState> emit) async {
    _streamSubscription?.cancel();
    _streamSubscription = _accountRepository.getAllAccount()
    .listen((accounts) async {
      add(UpdateAccounts(accounts));
    });
  }

  // need to load accounts
  void _updateAccounts(UpdateAccounts event, Emitter<AccountRepositoryState> emit) async {
    for (var element in event.accounts) {
      await _accountHiveRepository.putAccount(element);
    }
    emit(AccountLoaded(account: event.accounts));
  }
}
