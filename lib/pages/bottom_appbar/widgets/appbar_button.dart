import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';

class AppbarButton extends StatelessWidget {
  const AppbarButton({
    super.key, 
    required this.groupValue,
    required this.value,
    required this.icon,
    required this.padding,
    required this.controller,
  });
  final BottomAppbarTab groupValue;
  final BottomAppbarTab value;
  final Widget icon;
  final EdgeInsetsGeometry padding;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
      onPressed: () => controller.jumpToPage(value.index),
      iconSize: groupValue != value ? 20 : 26,
      color: groupValue != value ? Colors.white54 : const Color(0xFFFFFFFF),
      icon: icon
    );
  }
}