import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/settings/settings.dart';

class SettingsSelection extends StatelessWidget {
  const SettingsSelection({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Settings",
              style: TextStyle(
                color: Color(0x89000000),
                fontSize: 26.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10.0,),
            SettingsContainer(
              children: [
                SettingsButton(
                  colors:const Color(0xFF02AE08),
                  iconData: UniconsLine.outgoing_call,
                  text: "Contact FCB",
                  methods: () {},
                ),
                const SizedBox(height: 5.0),
                SettingsButton(
                  colors:const Color(0xFF02AE08),
                  iconData: UniconsLine.question_circle,
                  text: "FAQ",
                  methods: () {},
                ),
                const SizedBox(height: 5.0),
                SettingsButton(
                  colors:const Color(0xFF02AE08),
                  iconData: UniconsLine.globe,
                  text: "Website",
                  methods: () {},
                ),
                const SizedBox(height: 5.0),
                SettingsButton(
                  colors:const Color(0xFF00B2BE),
                  iconData: UniconsLine.apps,
                  text: "Check Update",
                  methods: () {},
                ),
                const SizedBox(height: 5.0),
                SettingsButton(
                  colors:const Color(0xFFFF594E),
                  iconData: UniconsLine.sign_out_alt,
                  text: "Logout",
                  methods: () {
                    context.read<AppBloc>().add(const AppLogoutRequested());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}