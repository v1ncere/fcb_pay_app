import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_appbar_nav_state.dart';

class BottomAppbarNavCubit extends Cubit<BottomAppbarNavState> {
  BottomAppbarNavCubit() : super(const BottomAppbarNavState());

  void setTab(BottomAppbarTab tab) {
    emit(state.copyWith(tab: tab));
  }
}