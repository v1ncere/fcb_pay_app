import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/repository.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final HiveRepository _accountHiveRepository;
  List<Account> _accounts = [];
  AccountsBloc(this._accountHiveRepository) : super(AccountsInitialState()) {
    on<AccountInitialEvent>(_onInitialAccountEventToState);
    on<AddAccountEvent>(_onAddAccountEventToState);
    on<EditAccountEvent>(_onEditAccountEventToState);
    on<DeleteAccountEvent>(_onDeleteAccountEventToState);
  }

  void _onInitialAccountEventToState(
    AccountInitialEvent event,
    Emitter<AccountsState> emit,
  ) async {
    emit(AccountsLoadingState());
    await getAccounts();
    emit(AccountsLoadedState(accounts: _accounts));
  }

  void _onAddAccountEventToState(
    AddAccountEvent event,
    Emitter<AccountsState> emit
  ) async {
    emit(AccountsLoadingState());
    await _accountHiveRepository.putAccount(event.account);

    await getAccounts();
    emit(AccountsLoadedState(accounts: _accounts));
  }

  void _onEditAccountEventToState(
    EditAccountEvent event,
    Emitter<AccountsState> emit,
  ) async {
    emit(AccountsLoadingState());
    await _accountHiveRepository.putAccount(event.accounts);

    await getAccounts();
    emit(AccountsLoadedState(accounts: _accounts));
  }

  void _onDeleteAccountEventToState(
    DeleteAccountEvent event,
    Emitter<AccountsState> emit,
  ) async {
    emit(AccountsLoadingState());
    await _accountHiveRepository.deleteAccount(event.account);

    await getAccounts();
    emit(AccountsLoadedState(accounts: _accounts));
  }

  Future<void> getAccounts() async {
    _accounts = await _accountHiveRepository.getAccounts();
  }
}
