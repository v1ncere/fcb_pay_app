part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class HomeAddressChanged extends AddressEvent {
  const HomeAddressChanged(this.homeAddress);
  final String homeAddress;

  @override
  List<Object> get props => [homeAddress];
}

class PostCodeChanged extends AddressEvent {
  const PostCodeChanged(this.postCode);
  final String postCode;

  @override
  List<Object> get props => [postCode];
}