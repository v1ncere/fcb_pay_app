import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerBody extends StatelessWidget {
  const ContainerBody({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color:const Color(0xFFEEEEEE),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color:const Color(0xFF000000).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3)
            ),
          ]
        ),
        child: ListView(
          children: children
        ),
      ),
    );
  }
}