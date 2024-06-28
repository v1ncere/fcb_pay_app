import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
      child: Text('Account settings',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
}
}