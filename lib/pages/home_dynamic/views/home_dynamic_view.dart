import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';
import 'package:fcb_pay_app/pages/home_dynamic/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class HomeDynamicView extends StatelessWidget {
  const HomeDynamicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AccountsBloc>().add(AccountsRefreshed());
          context.read<ButtonsBloc>().add(ButtonsRefreshed());
        },
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: HeaderCard(),
            ),
            ContainerBody( // Custom ListView container with design
              children: [
                SizedBox(height: 15),
                CarouselSliderDisplay(),
                SizedBox(height: 50),
                CardButtonMenu()
              ]
            )
          ]
        )
      )
    );
  }
}