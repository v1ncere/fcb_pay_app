import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/mobile_number/models/model_barrel.dart';
import 'package:formz/formz.dart';

part 'mobile_number_event.dart';
part 'mobile_number_state.dart';

class MobileNumberBloc extends Bloc<MobileNumberEvent, MobileNumberState> {
  MobileNumberBloc() : super(const MobileNumberState()) {
    on<MobileNumberChanged>(_onMobileNumberChanged);
  }

  void _onMobileNumberChanged(MobileNumberChanged event, Emitter<MobileNumberState> emit) {
    final mobileNumber = MobileNumber.dirty(event.mobileNumber);
    emit(state.copyWith(
      mobileNumber: mobileNumber,
      status: Formz.validate([
        mobileNumber,
      ]),
    ));
  }
}
