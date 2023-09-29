import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';
import 'package:fcb_pay_app/pages/home_dynamic/widgets/widgets.dart';

class CarouselSliderDisplay extends StatelessWidget {
  const CarouselSliderDisplay({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state is AccountsInProgress) {
          return const CarouselShimmer();
        }
        if (state is AccountsSuccess) {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, _) => context.read<SliderCubit>().setSliderIndex(index)
                ),
                items: state.accounts.map((data) {
                  if(data.type == 'cc') {
                    return CarouselCCCard( 
                      balance: data.balance,
                      creditLimit: data.creditLimit ?? 0.0,
                      expiry: data.expiry ?? DateTime.now(),
                      type: data.type,
                      ownerId: data.ownerId,
                      keyId: data.keyId!
                    );
                  }
                  if (data.type == 'sa' || data.type == 'wallet') {
                    return CarouselSACard(
                      balance: data.balance,
                      type: data.type,
                      ownerId: data.ownerId,
                      keyId: data.keyId!
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }).toList()
              ),
              BlocSelector<SliderCubit, int, int>(
                selector: (state) => state,
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
                          : Colors.black12,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // Shadow color
                              spreadRadius: 0.5,
                              blurRadius: 1.0,
                              offset: const Offset(0, 1.5)
                            )
                          ]
                        )
                      );
                    })
                  );
                }
              )
            ]
          );
        }
        if (state is AccountsError) {
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