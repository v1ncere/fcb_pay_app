import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';
import 'package:fcb_pay_app/pages/home_dynamic/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class CardButtonMenu extends StatelessWidget {
  const CardButtonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonsBloc, ButtonsState>(
      builder: (context, state) {
        if (state is ButtonsLoading) {
          return const ButtonShimmer();
        }
        if (state is ButtonsSuccess) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
            ),
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            shrinkWrap: true,
            itemCount: state.homeButtons.length,
            itemBuilder: (BuildContext context, int index) {
              final btn = state.homeButtons[index];
              return ButtonCard(
                title: btn.title,
                titleColor: colorStringParser(btn.titleColor), // color
                icon: iconMapper(btn.icon),
                iconColor: colorStringParser(btn.iconColor), // color
                bgColor: colorStringParser(btn.bgColor), // color
                function: () {
                  context.read<AppBloc>().add(AppDynamicButtonModelPassed(
                    ButtonModel(
                      id: btn.keyId!,
                      title: btn.title,
                      icon: btn.icon,
                      iconColor: btn.iconColor
                    )
                  ));
                  context.flow<AppStatus>().update((next) => AppStatus.dynamicPage);
                }
              );
            }
          );
        }
        if (state is ButtonsError) {
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