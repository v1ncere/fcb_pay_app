import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'buttons_event.dart';
part 'buttons_state.dart';

class ButtonsBloc extends Bloc<ButtonsEvent, ButtonsState> {
  ButtonsBloc() : super(ButtonsInitial()) {
    on<ButtonsEvent>((event, emit) {
      
    });
  }
}
