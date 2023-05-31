part of 'scanner_display_bloc.dart';

abstract class ScannerDisplayEvent extends Equatable {
  const ScannerDisplayEvent();

  @override
  List<Object> get props => [];
}

class ScannerDisplayLoaded extends ScannerDisplayEvent {}