import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _firebaseRepository = firebaseRepository,
  super(AccountsLoading()) {
    on<AccountsLoaded>(_onAccountsLoaded);
    on<AccountsUpdated>(_onAccountsUpdated);
    on<AccountsRefreshed>(_onAccountsRefreshed);
  }
  final FirebaseRealtimeDBRepository _firebaseRepository;
  StreamSubscription<List<Account>>? _streamSubscription;

  // fetching streamed data from firebase
  void _onAccountsLoaded(AccountsLoaded event, Emitter<AccountsState> emit) async {
    final internetStatus = await internetChecker();

    if(internetStatus) {
      _streamSubscription?.cancel;
      _streamSubscription = _firebaseRepository.getAccountListStream()
      .listen(
        (data) async {
          add(AccountsUpdated(data));
        }, onError: (error) {
          emit(AccountsError(error.toString()));
        }
      );
    } else {
      emit(const AccountsError('disconnected...'));
    }
  }

  // update accounts display when new data is added
  void _onAccountsUpdated(AccountsUpdated event, Emitter<AccountsState> emit) async {
     if (event.accounts.isNotEmpty) {
      List<Account> accountList = event.accounts;
      final walletAccount = accountList.firstWhere((acc) => acc.type.trim().toLowerCase() == 'wallet');
      final otherAccount = accountList.where((acc) => acc.type.trim().toLowerCase() != 'wallet').toList();
      
      final sortedAccounts = [ walletAccount, ...otherAccount ];
      emit(AccountsSuccess(accounts: sortedAccounts));
    } else {
      emit(const AccountsError('Empty'));
    }
  }

  void _onAccountsRefreshed(AccountsRefreshed event, Emitter<AccountsState> emit) {
    emit(AccountsLoading());
    add(AccountsLoaded());
  }

  @override
  Future<void> close() async {
    _streamSubscription?.cancel;
    return super.close();
  }
}
