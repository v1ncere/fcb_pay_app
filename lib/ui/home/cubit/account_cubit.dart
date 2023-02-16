import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fcb_pay_app/repository/repository.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({
    required AccountHiveRepository accountHiveRepository,
  }): _accountHiveRepository = accountHiveRepository,
      super(const AccountState());
  final AccountHiveRepository _accountHiveRepository;

  setData() async {
    emit(AccountState(account: await _accountHiveRepository.getAccounts()));
  }
}