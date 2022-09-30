import 'package:fcb_pay_app/ui/home/cubit/bottom_navigation_cubit.dart';
import 'package:fcb_pay_app/ui/home/tabs/tabs_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((BottomNavigationCubit cubit) => cubit.state.tab);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          HomeTab(text: "Hey",),
          PayTransactionTab(number: 11),
          ScannerTab(text: "Scanner",),
          SettingsTab(text: "Settings",),
          AboutUsTab(text: "AboutUs",)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _HomeTabButton(
                padding: const EdgeInsets.all(0.0),
                groupValue: selectedTab,
                value: BottomNavTab.home,
                icon: const Icon(UniconsLine.estate),
              ),
              _HomeTabButton(
                padding: const EdgeInsets.only(right: 28.0),
                groupValue: selectedTab,
                value: BottomNavTab.pay,
                icon: const Icon(UniconsLine.transaction),
              ),
              _HomeTabButton(
                padding: const EdgeInsets.only(left: 28.0),
                groupValue: selectedTab,
                value: BottomNavTab.settings,
                icon: const Icon(UniconsLine.setting),
              ),
              _HomeTabButton(
                padding: const EdgeInsets.all(0.0),
                groupValue: selectedTab,
                value: BottomNavTab.about,
                icon: const Icon(UniconsLine.info_circle),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => context.read<BottomNavigationCubit>().setTab(BottomNavTab.scanner),
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

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
    required this.padding,
  });

  final BottomNavTab groupValue;
  final BottomNavTab value;
  final Widget icon;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
      onPressed: () => context.read<BottomNavigationCubit>().setTab(value),
      iconSize: 32,
      color: groupValue != value ? Colors.black45 : const Color(0xFF009C05),
      icon: icon,
    );
  }
}