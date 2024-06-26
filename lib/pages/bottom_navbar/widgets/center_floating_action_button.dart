import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bottom_navbar.dart';

Widget centerFloatingActionButton({
    required BottomNavbarTab tab,
    required PageController controller
}) {
  return SizedBox(
    width: 65,
    height: 65,
    child: FloatingActionButton(
      elevation: 0.0,
      splashColor: Colors.tealAccent,
      shape: const CircleBorder(),
      backgroundColor: const Color(0xFF25C166),
      child: Icon(
        FontAwesomeIcons.qrcode,
        color: Colors.white,
        size: tab != BottomNavbarTab.scanner ? 22 : 26,
      ),
      onPressed: () => controller.jumpToPage(2),
    )
  );
}
