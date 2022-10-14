import 'package:fcb_pay_app/ui/bottom_appbar/cubit/bottom_appbar_cubit.dart';
import 'package:fcb_pay_app/ui/bottom_appbar/widgets/bottom_appbar_button.dart';
import 'package:fcb_pay_app/ui/home/home.dart';
import 'package:fcb_pay_app/ui/scanner/scanner.dart';
import 'package:fcb_pay_app/ui/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

class HomeBottomAppbarWidget extends StatelessWidget {
  const HomeBottomAppbarWidget({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((BottomAppbarCubit cubit) => cubit.state.tab);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          Home(),
          Scanner(),
          Settings(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
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
                icon: const Icon(UniconsSolid.house_user),
              ),
              BottomAppbarButton(
                padding: const EdgeInsets.all(0.0),
                groupValue: selectedTab,
                value: BottomAppbarTab.settings,
                icon: const Icon(Icons.settings_rounded),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            
            backgroundColor: Colors.white,
            onPressed: () => context.read<BottomAppbarCubit>().setTab(BottomAppbarTab.scanner),
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