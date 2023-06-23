import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_home/bottom_appbar_home.dart';

class CardHomeDisplay extends StatelessWidget {
  const CardHomeDisplay({super.key});
  
  @override
  Widget build(BuildContext context) {
    final current = context.select((SliderCubit cubit) => cubit.state.sliderIndex);

    return BlocBuilder<HomeDisplayBloc, HomeDisplayState>(
      builder: (context, state) {
        if (state is HomeDisplayLoadInProgress) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: SizedBox(
              height: 250,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is HomeDisplayLoadSuccess) {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  viewportFraction: 0.95,
                  height: MediaQuery.of(context).size.height * .68,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, _) => context.read<SliderCubit>().setSliderIndex(index),
                ),
                items: state.homeDisplay.map((data) {
                  return CardItem(
                    data: data.displayData,
                    ownerId: data.ownerId,
                    keyId: data.keyId!,
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(state.homeDisplay.toList(), (index, _) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: current == index
                        ? Colors.greenAccent
                        : Colors.black12,
                    ),
                  );
                }),
              ),
            ],
          );
        }
        if (state is HomeDisplayLoadError) {
          return Center(
            child: Text(state.error,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w700,
              )
            )
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}