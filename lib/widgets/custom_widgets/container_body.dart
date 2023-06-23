import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerBody extends StatelessWidget {
  const ContainerBody({
    super.key,
    required this.children
  });
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color:const Color(0xFFFFFFFF),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color:const Color(0xFF000000).withOpacity(0.5),
              spreadRadius: 0.1,
              blurRadius: 2,
              offset: const Offset(0, -1),
            )
          ],
        ),
        child: ListView(
          children: children
        ),
      ),
    );
  }
}