import 'package:flutter/material.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const[
        Flexible(
          flex: 1,
          child: Text('Phone Number: ', style: TextStyle(color: Color(0xFF687ea1), fontSize: 16))),
        Flexible(
          flex: 1,
          child: Text('09504168689', style: TextStyle(color: Color(0xFF687ea1), fontSize: 22))),
      ]
    );
  }
}