part of 'display_payment_data_bloc.dart';

abstract class DisplayPaymentDataEvent extends Equatable {
  const DisplayPaymentDataEvent();

  @override
  List<Object> get props => [];
}

class DisplayPaymentDataLoaded extends DisplayPaymentDataEvent {}
