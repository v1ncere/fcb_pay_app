import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app.dart';
import '../../account_settings/account_settings.dart';
import '../../home/home.dart';
import '../../home_flow/home_flow.dart';
import '../../payments/payments.dart';
import '../../scanner/scanner.dart';
import '../../transfers/transfers.dart';
import '../bottom_navbar.dart';

class BottomNavbarView extends StatelessWidget {
  const BottomNavbarView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocSelector<BottomNavbarCubit, BottomNavbarTab, BottomNavbarTab>(
      selector: (state) => state,
      builder: (context, tab) {
        final controller = PageController(initialPage: tab.index);
        _inactivityResume(context);
        return InactivityDetector(
          onInactive: () => context.flow<HomeRouterStatus>().complete(),
          child: Scaffold(
            extendBody: true, // for QR scanner to occupy the whole screen
            drawer: const SideDrawer(),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (index) => context.read<BottomNavbarCubit>().setTab(BottomNavbarTab.values[index]),
              children: const [
                HomePage(),
                PaymentsPage(),
                ScannerPage(),
                TransfersPage(),
                AccountSettingsPage()
              ]
            ),
            bottomNavigationBar: bottomNavAppBar(tab: tab, controller: controller),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: centerFloatingActionButton(tab: tab, controller: controller)
          )
        );
      }
    );
  }
  // UTILITY METHODS
  void _inactivityResume(BuildContext context) => context.read<InactivityCubit>().resumeTimer();
}