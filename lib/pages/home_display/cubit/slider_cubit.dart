import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(const SliderState());

  void setSliderIndex(index) => emit(SliderState(sliderIndex: index));
}
