import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_pin_event.dart';
part 'change_pin_state.dart';

class ChangePinBloc extends Bloc<ChangePinEvent, ChangePinState> {
  ChangePinBloc() : super(ChangePinInitial()) {
    on<ChangePinEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
