import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../utils/utils.dart';

part 'accounts_home_event.dart';
part 'accounts_home_state.dart';

class AccountsHomeBloc extends Bloc<AccountsHomeEvent, AccountsHomeState> {
  AccountsHomeBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
    required HiveRepository hiveRepository
  }) : _firebaseDatabase = firebaseRealtimeDBRepository,
  _hiveRepository = hiveRepository,
  super(const AccountsHomeState(status: Status.loading, userDetailStatus: Status.loading)) {
    on<AccountsHomeLoaded>(_onAccountsHomeLoaded);
    on<AccountsHomeUpdated>(_onAccountsUpdated);
    on<UserDetailsStreamed>(_onUserDetailsStreamed);
    on<UserDetailsUpdated>(_onUserDetailsUpdated);
    on<DepositDisplayChanged>(_onDepositDisplayChanged);
    on<CreditDisplayChanged>(_onCreditDisplayChanged);
    on<AccountsHomeRefreshed>(_onAccountsHomeRefreshed);
  }
  final HiveRepository _hiveRepository;
  final FirebaseRealtimeDBRepository _firebaseDatabase;
  StreamSubscription<List<Account>>? _accountSubscription;
  StreamSubscription<UserDetails>? _userDetailSubscription;

  // check network connectivity
  void _onAccountsHomeLoaded(AccountsHomeLoaded event, Emitter<AccountsHomeState> emit) async {
    await _fetchDataAndRefreshState(emit);
  }

  void _onAccountsUpdated(AccountsHomeUpdated event, Emitter<AccountsHomeState> emit) async {
    if (event.accountList.isNotEmpty) {
      final accountList = event.accountList; // assign to a new list
      Account wallet = _getAccountOfCategory(accountList, 'wallet'); // locate the wallet account
      Account deposit = await _getDepositAccount(accountList); // locate the deposit account
      Account credit = await _getCreditAccount(accountList); // locate the credit account

      emit(state.copyWith(
        status: Status.success,
        accountList: accountList,
        wallet: wallet,
        deposit: deposit,
        credit: credit
      ));
    } else {
      emit(state.copyWith(status: Status.error, message: 'Empty'));
    }
  }

  void _onUserDetailsStreamed(UserDetailsStreamed event, Emitter<AccountsHomeState> emit) async {
    await _fetchUserDetailStream(emit);
  }

  void _onUserDetailsUpdated(UserDetailsUpdated event, Emitter<AccountsHomeState> emit) {
    if(event.userDetails.isNotEmpty) {
      final user = event.userDetails;
      emit(state.copyWith(userDetailStatus: Status.success, userDetails: user));
    } else {
      emit(state.copyWith(userDetailStatus: Status.error, message: 'Empty'));
    }
  }

  // change deposit display
  void _onDepositDisplayChanged(DepositDisplayChanged event, Emitter<AccountsHomeState> emit) async {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    _hiveRepository.addDepositId(uid: uid, account: event.id); // save id into local storage using [hive]
    emit(state.copyWith(status: Status.loading)); // emit status loading
    await _fetchDataAndRefreshState(emit); // refresh the state
  }

  // change credit display
  void _onCreditDisplayChanged(CreditDisplayChanged event, Emitter<AccountsHomeState> emit) async {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    _hiveRepository.addCreditId(uid: uid, account: event.id); // save id into local storate using [hive]
    emit(state.copyWith(status: Status.loading)); // emit status loading
    await _fetchDataAndRefreshState(emit); // refresh the state
  }

  // refresh the state
  void _onAccountsHomeRefreshed(AccountsHomeRefreshed event, Emitter<AccountsHomeState> emit) async {
    emit(state.copyWith(status: Status.loading, userDetailStatus: Status.loading)); // emit status loading
    await _fetchDataAndRefreshState(emit); // refresh the state
    await _fetchUserDetailStream(emit);
  }

  // SECONDARY METHODS ===============================================================================
  // =================================================================================================

  // fetching list of accounts from firebase realtime database
  Future<void> _fetchDataAndRefreshState(Emitter<AccountsHomeState> emit) async {
    final isConnected = await checkNetworkStatus();
    
    if (isConnected) {
      _accountSubscription?.cancel();
      _accountSubscription = _firebaseDatabase.getAccountListStream()
      .listen((accountList) {
        add(AccountsHomeUpdated(accountList));
      }, onError: (error) {
        emit(state.copyWith(status: Status.error, message: error.toString()));
      });
    } else {
      emit(state.copyWith(status: Status.error, message: TextString.internetError));
    }
  }

  Future<void> _fetchUserDetailStream(Emitter<AccountsHomeState> emit) async {
    final isConnected = await checkNetworkStatus();
    
    if (isConnected) {
      _userDetailSubscription?.cancel();
      _userDetailSubscription = _firebaseDatabase.getUserDetails()
      .listen((event) {
        add(UserDetailsUpdated(event));
      });
    } else {
      emit(state.copyWith(userDetailStatus: Status.error, message: TextString.internetError));
    }
  }

  // get the category of an Account
  Account _getAccountOfCategory(List<Account> accountList, String category) {
    try {
      return accountList.firstWhere((account) => account.category.toLowerCase() == category);
    } catch (_) {
       return Account.empty;
    }
  }

  // sort the list of Accounts and return the  latest
  Account getLatestAccount(List<Account> accountList, String category) {
    accountList.sort((a, b) => b.timeStamp!.compareTo(a.timeStamp!));
    return accountList.firstWhere((account) => account.category.toLowerCase() == category);
  }

  // get the specific "deposit" account
  Future<Account> _getDepositAccount(List<Account> accountList) async {
    if(isDepositsExist(accountList)) {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final id = await _hiveRepository.getDepositId(uid); // id saved from local storage [hive]
      return id.isNotEmpty
      ? accountList.firstWhere((account) => account.accountKeyID! == id) // if id is not empty, locate the account equals to the id
      : getLatestAccount(accountList, 'deposit'); // if id is empty get the latest account
    }
    return Account.empty;
  }

  // check if category "deposit" exist in the List<Account>
  bool isDepositsExist(List<Account> accountList) {
    final deposit = accountList.where((account) => account.category.toLowerCase() == 'deposit');
    return deposit.isNotEmpty;
  }

  // get the specific "credit" account
  Future<Account> _getCreditAccount(List<Account> accountList) async {
    if(isCreditExist(accountList)) {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final id = await _hiveRepository.getCreditId(uid); // id saved from local storage [hive]
      return id.isNotEmpty
      ? accountList.firstWhere((account) => account.accountKeyID! == id) // if id is not empty, locate the account equals to the id
      : getLatestAccount(accountList, 'credit'); // if id is empty get the latest account
    }
    return Account.empty;
  }

  // check if category "deposit" exist in the List<Account>
  bool isCreditExist(List<Account> accountList) {
    final credit = accountList.where((account) => account.category.toLowerCase() == 'credit');
    return credit.isNotEmpty;
  }

  @override
  Future<void> close() async {
    _accountSubscription?.cancel();
    _userDetailSubscription?.cancel();
    return super.close();
  }
}
