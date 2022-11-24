import 'package:fcb_pay_app/ui/bottom_appbar/cubit/bottom_appbar_cubit.dart';
import 'package:flutter/material.dart';

class BottomAppbarButton extends StatelessWidget {
  const BottomAppbarButton({
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
      iconSize: groupValue != value ? 32 : 35,
      color: groupValue != value ? Colors.white70 : const Color(0xFFFFFFFF),
      icon: icon,
    );
  }
}