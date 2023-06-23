part of 'slider_cubit.dart';

class SliderState extends Equatable {
  const SliderState({this.sliderIndex = 0});
  final int sliderIndex;

  @override
  List<Object> get props => [sliderIndex];
}
