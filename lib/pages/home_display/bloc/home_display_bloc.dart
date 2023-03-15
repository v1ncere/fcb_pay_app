import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_display_event.dart';
part 'home_display_state.dart';

class HomeDisplayBloc extends Bloc<HomeDisplayEvent, HomeDisplayState> {
  HomeDisplayBloc() : super(HomeDisplayInitial()) {
    on<HomeDisplayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
