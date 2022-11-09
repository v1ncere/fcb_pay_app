part of 'mobile_number_bloc.dart';

abstract class MobileNumberEvent extends Equatable {
  const MobileNumberEvent();

  @override
  List<Object> get props => [];
}

class MobileNumberChanged extends MobileNumberEvent {
  const MobileNumberChanged(this.mobileNumber);
  final String mobileNumber;

  @override
  List<Object> get props => [mobileNumber];
}
