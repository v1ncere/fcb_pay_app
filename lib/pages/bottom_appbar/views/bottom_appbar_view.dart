import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/home_display/home_display.dart';
import 'package:fcb_pay_app/pages/payment_and_transfers/payment_and_transfers.dart';
import 'package:fcb_pay_app/pages/transaction_history/transaction_history.dart';

class HomeBottomAppbarView extends StatelessWidget {
  const HomeBottomAppbarView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((BottomAppbarCubit cubit) => cubit.state.tab);
    final controller = PageController(initialPage: selectedTab.index);
    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: (index) => context.read<BottomAppbarCubit>().setTab(BottomAppbarTab.values[index]),
        children: const [
          HomeDisplayPage(),
          PaymentAndTransfersPage(),
          TransactionHistoryPage(),
          AccountSettingsPage(),
        ],
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
              BottomAppbarButton(
                padding: const EdgeInsets.all(0.0),
                groupValue: selectedTab,
                value: BottomAppbarTab.home,
                controller: controller,
                icon: const FaIcon(FontAwesomeIcons.house),
              ),
              BottomAppbarButton(
                padding: const EdgeInsets.all(0.0),
                groupValue: selectedTab,
                value: BottomAppbarTab.transfer,
                controller: controller,
                icon: const FaIcon(FontAwesomeIcons.moneyBillTransfer),
              ),
              BottomAppbarButton(
                padding: const EdgeInsets.all(0.0),
                groupValue: selectedTab,
                value: BottomAppbarTab.history,
                controller: controller,
                icon: const FaIcon(FontAwesomeIcons.clockRotateLeft),
              ),
              BottomAppbarButton(
                padding: const EdgeInsets.all(0.0),
                groupValue: selectedTab,
                value: BottomAppbarTab.accounts,
                controller: controller,
                icon: const FaIcon(FontAwesomeIcons.solidIdCard),
              ),
            ],
          ),
        ),
      ),
    );
  }
}