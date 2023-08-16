import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home/home.dart';
import 'package:fcb_pay_app/pages/home/widgets/widgets.dart';

class CarouselCardDisplay extends StatelessWidget {
  const CarouselCardDisplay({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountDisplayBloc, AccountDisplayState>(
      builder: (context, state) {
        if (state is AccountDisplayInProgress) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: SizedBox(
              height: 250,
              child: Center(
                child: CircularProgressIndicator()
              )
            )
          );
        }
        if (state is AccountDisplaySuccess) {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  enlargeCenterPage: true,
                  viewportFraction: 0.94,
                  height: MediaQuery.of(context).size.height * .67,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, _) => context.read<SliderCubit>().setSliderIndex(index)
                ),
                items: state.accounts.map((data) {
                  return CarouselCardItem(
                    data: data.displayData,
                    ownerId: data.ownerId,
                    keyId: data.keyId!
                  );
                }).toList()
              ),
              BlocSelector<SliderCubit, SliderState, int>(
                selector: (state) => state.sliderIndex,
                builder: (_, currentIndex) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(state.accounts.toList(), (index, _) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == index
                          ? Colors.greenAccent[400]
                          : Colors.black12
                        )
                      );
                    })
                  );
                }
              )
            ]
          );
        }
        if (state is AccountDisplayError) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w700
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