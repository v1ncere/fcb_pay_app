import 'package:fcb_pay_app/ui/settings/widgets/settings_button.dart';
import 'package:fcb_pay_app/ui/settings/widgets/settings_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class SettingsSelection extends StatelessWidget {
  const SettingsSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0, left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Settings", style: TextStyle(
            color: Color(0x89000000),
            fontSize: 26.0,
            fontWeight: FontWeight.w400,
          ),),
          SizedBox(height: 10.0,),
          SettingsContainer(
            children: [
              SettingsButton(colors: Color(0xFF02AE08), iconData: UniconsLine.sliders_v_alt, text: "Configure App",),
              SizedBox(height: 3.0),
              SettingsButton(colors: Color(0xFF02AE08), iconData: UniconsLine.building, text: "Enroll Bills Payment Institution",),
              SizedBox(height: 3.0),
              SettingsButton(colors: Color(0xFF02AE08), iconData: UniconsLine.slider_h_range, text: "Manage Enrolled Accounts",),
              SizedBox(height: 3.0),
              SettingsButton(colors: Color(0xFF02AE08), iconData: UniconsLine.signal, text: "Preferred Network",),
              SizedBox(height: 3.0),
              SettingsButton(colors: Color(0xFF02AE08), iconData: UniconsLine.sign_in_alt, text: "Login Options",),
              SizedBox(height: 3.0),
              SettingsButton(colors: Color(0xFF02AE08), iconData: UniconsLine.sim_card, text: "Sim Slot",),
              SizedBox(height: 3.0),
              SettingsButton(colors: Color(0xFF02AE08), iconData: UniconsLine.outgoing_call, text: "Contact FCB",),
              SizedBox(height: 3.0),
              SettingsButton(colors: Color(0xFF02AE08), iconData: UniconsLine.question_circle, text: "FAQ",),
              SizedBox(height: 3.0),
              SettingsButton(colors: Color(0xFF02AE08), iconData: UniconsLine.globe, text: "Website",),
              SizedBox(height: 3.0),
              SettingsButton(colors: Color(0xFF00B2BE), iconData: UniconsLine.apps, text: "Check Update",),
              SizedBox(height: 3.0),
              SettingsButton(colors: Color(0xFFFF594E), iconData: UniconsLine.sign_out_alt, text: "Logout",),
            ],)
      ]),
    );
  }
}