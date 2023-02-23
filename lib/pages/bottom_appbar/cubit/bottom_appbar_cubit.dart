import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_appbar_state.dart';

class BottomAppbarCubit extends Cubit<BottomAppbarState> {
  BottomAppbarCubit() : super(const BottomAppbarState());

  void setTab(BottomAppbarTab tab) => emit(state.copyWith(tab: tab));
}