import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_appbar_state.dart';

class BottomAppbarCubit extends Cubit<BottomAppbarState> {
  BottomAppbarCubit() : super(const BottomAppbarState());

  void setTab(BottomAppbarTab tab) => emit(BottomAppbarState(tab: tab));
}
