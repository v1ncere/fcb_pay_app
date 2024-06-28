import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit() : super(const CarouselState());

  void setSlideIndex({required int index}) => emit(state.copyWith(index: index));

  void setAccount({required Account account}) => emit(state.copyWith(account: account)); 
}
