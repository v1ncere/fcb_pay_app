import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbarCubit extends Cubit<BottomNavbarTab> {
  BottomNavbarCubit() : super(BottomNavbarTab.home);

  void setTab(BottomNavbarTab tab) => emit(tab);
}

enum BottomNavbarTab { home, payments, scanner, transfers, accounts }