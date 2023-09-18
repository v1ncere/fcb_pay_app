import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';
import 'package:fcb_pay_app/pages/home_dynamic/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/icon_mapper.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class CardButtonMenu extends StatelessWidget {
  const CardButtonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonsBloc, ButtonsState>(
      builder: (context, state) {
        if (state is ButtonsLoading) {
          return const Center(child: CircularProgressIndicator());
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
                titleColor: Color(btn.titleColor),
                icon: iconMapper(btn.icon),
                iconColor: Color(btn.iconColor),
                bgColor: Color(btn.titleColor),
                function: () {

                }
              );
            }
          );
        } 
        if (state is ButtonsError) {
          return Center(
            child: Text(state.error),
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}