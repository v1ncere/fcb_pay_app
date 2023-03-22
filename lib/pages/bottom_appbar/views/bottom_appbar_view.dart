import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/home_display/home_display.dart';
import 'package:fcb_pay_app/pages/scanner/scanner.dart';
import 'package:fcb_pay_app/pages/settings/settings.dart';

class HomeBottomAppbarView extends StatelessWidget {
  const HomeBottomAppbarView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((BottomAppbarCubit cubit) => cubit.state.tab);
    final controller = PageController(initialPage: selectedTab.index);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: (index) => context.read<BottomAppbarCubit>().setTab(BottomAppbarTab.values[index]),
        children: const [
          HomeDisplayPage(),
          ScannerPage(),
          SettingsPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.hardEdge,
        color:const Color(0xFF009C05),
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomAppbarButton(
                padding: const EdgeInsets.all(0.0),
                groupValue: selectedTab,
                value: BottomAppbarTab.home,
                controller: controller,
                icon: const Icon(UniconsSolid.house_user),
              ),
              BottomAppbarButton(
                padding: const EdgeInsets.all(0.0),
                groupValue: selectedTab,
                value: BottomAppbarTab.settings,
                controller: controller,
                icon: const Icon(Icons.settings_rounded),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox.fromSize(
        size: const Size(70.0, 70.0),
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => controller.jumpToPage(BottomAppbarTab.scanner.index),
            child: Container(
              height: 65.0,
              width: 65.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment(0.0, 0.0),
                  radius: 0.5,
                  colors: [Color(0xFFB0F87D), Color(0xFF02AE08)],
                ),
              ),
              child: const Icon(UniconsLine.qrcode_scan, color: Color(0xFFFFFFFF)),
            ),  
          ),
        ),
      ),
    );
  }
}