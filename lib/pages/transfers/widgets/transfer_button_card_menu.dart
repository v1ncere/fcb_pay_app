import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../../bottom_navbar/bottom_navbar.dart';
import '../../home_flow/home_flow.dart';
import '../transfers.dart';
import 'widgets.dart';

class TransferButtonCardMenu extends StatelessWidget {
  const TransferButtonCardMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferButtonsBloc, TransferButtonsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const ButtonShimmer();
        }
        if (state.status.isSuccess) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
            ),
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            shrinkWrap: true,
            itemCount: state.buttons.length,
            itemBuilder: (BuildContext context, int index) {
              final button = state.buttons[index];
              return ButtonCard(
                title: button.title,
                titleColor: colorStringParser(button.titleColor),
                icon: iconMapper(button.icon),
                iconColor: colorStringParser(button.iconColor),
                bgColor: colorStringParser(button.bgColor),
                function: () {
                  // timer paused, halt the navigation process
                  context.read<InactivityCubit>().pauseTimer();
                  context.read<RouterBloc>().add(RouterPaymentsButtonPassed(button));
                  context.flow<HomeRouterStatus>().update((next) => HomeRouterStatus.transfersView);
                }
              );
            }
          );
        }
        if (state.status.isError) {
          return Center(
            child: Text(
              state.message,
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
}