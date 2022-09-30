import 'package:flutter/material.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const[
          Text('Phone Number: ', style: TextStyle(color: Color(0xFF687ea1), fontSize: 16)),
          Text('09504168689', style: TextStyle(color: Color(0xFF687ea1), fontSize: 22)),
        ]
      )
    );
  }
}