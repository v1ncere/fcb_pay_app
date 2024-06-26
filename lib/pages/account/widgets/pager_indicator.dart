import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../account.dart';

Widget pagerIndicator({
  required AccountsState state
}) {
  return BlocSelector<CarouselCubit, CarouselState, int>(
    selector: (state) => state.index,
    builder: (context, current) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          state.accountList.toList(), 
          (index, _) {
            return Container(
              width: 5.0,
              height: 5.0,
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 2.0
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current == index
                ? ColorString.algaeGreen
                : Colors.black12,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 1.0,
                    offset: const Offset(0, 1.5)
                  )
                ]
              )
            );
          }
        )
      );
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