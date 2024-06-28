import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpStepperCubit extends Cubit<int> {
  SignUpStepperCubit({required this.length}) : super(0);
  final int length;

  void stepTapped(int index) => emit(index);

  void stepContinued() => emit((state < length - 1) ? state + 1 : state);

  void stepCancelled() => emit((state > 0) ? state - 1 : state);
}
