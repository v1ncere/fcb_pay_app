import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/widgets/widgets.dart';
import 'package:fcb_pay_app/pages/home/home.dart';
import 'package:fcb_pay_app/pages/scanner/scanner.dart';

class BottomAppbarView extends StatelessWidget {
  const BottomAppbarView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocSelector<BottomAppbarCubit, BottomAppbarState, BottomAppbarTab>(
      selector: (state) => state.tab,
      builder: (context, tab) {
        final controller = PageController(initialPage: tab.index);
        return Scaffold(
          extendBody: true,
          body: SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (index) => context.read<BottomAppbarCubit>().setTab(BottomAppbarTab.values[index]),
              children: const [
                HomePage(),
                ScannerPage(),
                AccountSettingsPage()
              ]
            )
          ),
          bottomNavigationBar: BottomAppBar(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color:const Color(0xFFFFFFFF),
            shape: const CircularNotchedRectangle(),
            child: SizedBox(
              height: 55,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppbarButton(
                    padding: const EdgeInsets.all(0.0),
                    groupValue: tab,
                    value: BottomAppbarTab.home,
                    controller: controller,
                    icon: Icon(
                      FontAwesomeIcons.house, 
                      shadows: BottomAppbarTab.home == tab
                      ? [
                          Shadow(
                            color: Colors.black.withOpacity(0.2), // Shadow color
                            blurRadius: 4.0
                          )
                        ]
                      : null
                    )
                  ),
                  AppbarButton(
                    padding: const EdgeInsets.all(0.0),
                    groupValue: tab,
                    value: BottomAppbarTab.accounts,
                    controller: controller,
                    icon: Icon(
                      FontAwesomeIcons.solidIdCard,
                      shadows: BottomAppbarTab.accounts == tab
                      ? [
                          Shadow(
                            color: Colors.black.withOpacity(0.2), // Shadow color
                            blurRadius: 4.0
                          )
                        ]
                      : null
                    )
                  )
                ]
              )
            )
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: SizedBox(
            width: 65,
            height: 65,
            child: FloatingActionButton(
              splashColor: Colors.tealAccent,
              backgroundColor: const Color(0xFF25C166),
              child: Icon(
                FontAwesomeIcons.qrcode, 
                color: Colors.white,
                size: tab != BottomAppbarTab.scanner ? 22 : 26,
              ),
              onPressed: () => controller.jumpToPage(1),
            )
          )
        );
      }
    );
  }
}