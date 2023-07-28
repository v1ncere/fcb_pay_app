import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';
import 'package:fcb_pay_app/pages/home/home.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_nav/bottom_appbar_nav.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_nav/widgets/widgets.dart';
import 'package:fcb_pay_app/pages/payment_and_transfers/payment_and_transfers.dart';

class BottomAppbarNavView extends StatelessWidget {
  const BottomAppbarNavView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocSelector<BottomAppbarNavCubit, BottomAppbarNavState, BottomAppbarTab>(
      selector: (state) => state.tab,
      builder: (context, selectedTab) {
        final controller = PageController(initialPage: selectedTab.index);
        return Scaffold(
          extendBody: true,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            onPageChanged: (index) => context.read<BottomAppbarNavCubit>().setTab(BottomAppbarTab.values[index]),
            children: const [
              HomePage(),
              PaymentAndTransfersPage(),
              AccountSettingsPage()
            ]
          ),
          bottomNavigationBar: BottomAppBar(
            clipBehavior: Clip.hardEdge,
            color:const Color(0xFF009C05),
            shape: const CircularNotchedRectangle(),
            child: SizedBox(
              height: 55,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppbarButton(
                    padding: const EdgeInsets.all(0.0),
                    groupValue: selectedTab,
                    value: BottomAppbarTab.home,
                    controller: controller,
                    icon: const FaIcon(FontAwesomeIcons.house),
                  ),
                  AppbarButton(
                    padding: const EdgeInsets.all(0.0),
                    groupValue: selectedTab,
                    value: BottomAppbarTab.transfer,
                    controller: controller,
                    icon: const FaIcon(FontAwesomeIcons.moneyBillTransfer),
                  ),
                  AppbarButton(
                    padding: const EdgeInsets.all(0.0),
                    groupValue: selectedTab,
                    value: BottomAppbarTab.accounts,
                    controller: controller,
                    icon: const FaIcon(FontAwesomeIcons.solidIdCard)
                  )
                ]
              )
            )
          )
        );
      }
    );
  }
}