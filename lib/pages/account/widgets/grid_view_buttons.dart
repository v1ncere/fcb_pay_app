import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/bloc/account_button_bloc.dart';
import 'package:fcb_pay_app/pages/account/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class GridViewButtons extends StatelessWidget {
  const GridViewButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountButtonBloc, AccountButtonState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const ButtonShimmer();
        }
        if (state.status.isSuccess) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 400 ? 4 : 3, // larger width screen the more the button display
                ),
                shrinkWrap: true,
                itemCount: state.buttonList.length,
                itemBuilder: (BuildContext context, int index) {
                  final btn = state.buttonList[index];
                  return CircleButtonWithLabel(
                    icon: iconMapper(btn.icon),
                    color: colorStringParser(btn.iconColor),
                    text: btn.title,
                    function: () {
                      context.read<AppBloc>().add(
                        AppAccountDynamicButtonModelPassed(
                          ButtonModel(
                            id: btn.keyId!,
                            title: btn.title,
                            icon: btn.icon,
                            iconColor: btn.iconColor
                          )
                        )
                      );
                      context.flow<AppStatus>().update((next) => AppStatus.accountDynamicPage);
                    }
                  );
                }
              );
            }
          );
        }
        if (state.status.isError) {
          return Center(child: Text(state.message));
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}