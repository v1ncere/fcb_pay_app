import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbarCubit extends Cubit<BottomNavbarTab> {
  BottomNavbarCubit() : super(BottomNavbarTab.home);

  void setTab(BottomNavbarTab tab) => emit(tab);
}

enum BottomNavbarTab { home, payments, scanner, transfers, accounts }

extension BottomNavbarTabX on BottomNavbarTab {
  bool get isHome => this == BottomNavbarTab.home;
  bool get isPayments => this == BottomNavbarTab.payments;
  bool get isScanner => this == BottomNavbarTab.scanner;
  bool get isTransfers => this == BottomNavbarTab.transfers;
  bool get isAccounts => this == BottomNavbarTab.accounts;
}