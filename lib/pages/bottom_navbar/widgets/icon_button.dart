import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../bottom_navbar.dart';

Widget iconButton({
  required BottomNavbarTab  groupValue,
  required BottomNavbarTab value,
  required Widget icon,
  required PageController controller
}) {
  return IconButton(
    onPressed: () => controller.jumpToPage(value.index),
    iconSize: groupValue != value ? 20 : 28,
    color: groupValue != value ? Colors.black26 : ColorString.white,
    icon: icon,
  );
}
