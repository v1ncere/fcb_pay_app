part of 'address_bloc.dart';

class AddressState extends Equatable {
  const AddressState({
    this.homeAddress = const HomeAddress.pure(),
    this.postCode = const PostCode.pure(),
    this.status = FormzStatus.pure,
  });

  final HomeAddress homeAddress;
  final PostCode postCode;
  final FormzStatus status;

  AddressState copyWith({
    HomeAddress? homeAddress,
    PostCode? postCode,
    FormzStatus? status,
  }) {
    return AddressState(
      homeAddress: homeAddress ?? this.homeAddress,
      postCode: postCode ?? this.postCode,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [homeAddress, postCode, status];
}