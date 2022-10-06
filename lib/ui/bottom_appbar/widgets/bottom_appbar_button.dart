import 'package:fcb_pay_app/ui/bottom_appbar/cubit/bottom_appbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomAppbarButton extends StatelessWidget {
  const BottomAppbarButton({Key? key, 
    required this.groupValue,
    required this.value,
    required this.icon,
    required this.padding,
  }) : super(key: key);

  final BottomAppbarTab groupValue;
  final BottomAppbarTab value;
  final Widget icon;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
      onPressed: () => context.read<BottomAppbarCubit>().setTab(value),
      iconSize: 32,
      color: groupValue != value ? Colors.black45 : const Color(0xFF009C05),
      icon: icon,
    );
  }
}