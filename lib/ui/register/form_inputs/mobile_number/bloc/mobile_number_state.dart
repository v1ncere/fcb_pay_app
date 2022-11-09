part of 'mobile_number_bloc.dart';

class MobileNumberState extends Equatable {
  const MobileNumberState({
    this.mobileNumber = const MobileNumber.pure(),
    this.status = FormzStatus.pure,
  });

  final MobileNumber mobileNumber;
  final FormzStatus status;
  
  MobileNumberState copyWith({
    MobileNumber? mobileNumber,
    FormzStatus? status,
  }) {
    return MobileNumberState (
      mobileNumber: mobileNumber ?? this.mobileNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [];
}