import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/address/models/model_barrel.dart';
import 'package:formz/formz.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(const AddressState()) {
    on<HomeAddressChanged>(_onHomeAddressChanged);
    on<PostCodeChanged>(_onPostCodeChanged);
  }

  void _onHomeAddressChanged(HomeAddressChanged event, Emitter<AddressState> emit) {
    final homeAddress = HomeAddress.dirty(event.homeAddress);
    emit(state.copyWith(
      homeAddress: homeAddress,
      status: Formz.validate([
        homeAddress,
        state.postCode,
      ]),
    ));
  }

  void _onPostCodeChanged(PostCodeChanged event, Emitter<AddressState> emit) {
    final postCode = PostCode.dirty(event.postCode);
    emit(state.copyWith(
      postCode: postCode,
      status: Formz.validate([
        state.homeAddress,
        postCode,
      ]),
    ));
  }
}
