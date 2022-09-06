import 'package:bloc/bloc.dart';
import 'package:fcb_pay_app/db/pin_repository.dart';
import 'package:meta/meta.dart';

part 'create_pin_event.dart';
part 'create_pin_state.dart';

class CreatePinBloc extends Bloc<CreatePinEvent, CreatePinState> {
  final PinRepository pinRepository;

  CreatePinBloc({required this.pinRepository}) : super(const CreatePinState(pinStatus: PinStatus.enterFirst)) {
    on<CreatePinAddEvent>((event, emit) {
      if (state.firstPin.length < 4) {
        String firstPIN = "${state.firstPin}${event.pinNum}";
        if (firstPIN.length < 4) {
          emit(CreatePinState(firstPin: firstPIN, pinStatus: PinStatus.enterFirst));
        } else {
          emit(CreatePinState(firstPin: firstPIN, pinStatus: PinStatus.enterSecond));
        }
      } else {
        String secondPIN = "${state.secondPin}${event.pinNum}";
        if (secondPIN.length < 4) {
          emit(state.copyWith(secondPin: secondPIN, pinStatus: PinStatus.enterSecond));
        } else if (secondPIN == state.firstPin) {
          pinRepository.addPin(secondPIN);
          emit(state.copyWith(secondPin: secondPIN, pinStatus: PinStatus.equals));
        } else {
          emit(state.copyWith(secondPin: secondPIN, pinStatus: PinStatus.unequals));
        }
      }
    });
    on<CreatePinEraseEvent>((event, emit) {
      if (state.firstPin.isEmpty) {
        emit(const CreatePinState(pinStatus: PinStatus.enterFirst));
      } else if (state.firstPin.length < 4) {
        String firstPIN = state.firstPin.substring(0, state.firstPin.length - 1);
        emit(CreatePinState(firstPin: firstPIN, pinStatus: PinStatus.enterFirst));
      } else if (state.secondPin.isEmpty) {
        emit(state.copyWith(pinStatus: PinStatus.enterSecond));
      } else {
        String secondPIN = state.secondPin.substring(0, state.secondPin.length - 1);
        emit(state.copyWith(secondPin: secondPIN, pinStatus: PinStatus.enterSecond));
      }
    });
    on<CreateNullPinEvent>((event, emit) {
      emit(const CreatePinState(pinStatus: PinStatus.enterFirst));
    });
  }

  @override
  Future<void> close() {
    pinRepository.close();
    return super.close();
  }
}