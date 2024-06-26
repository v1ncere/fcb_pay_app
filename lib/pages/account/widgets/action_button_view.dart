import 'package:flutter/material.dart';

import 'widgets.dart';

class ActionButtonView extends StatelessWidget {
  const ActionButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( 
            'Actions',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w900
            )
          ),
          Divider(color: Color(0xFF25C166)),
          SizedBox(height: 10),
          GridViewButtons()
        ]
      )
    );
  }
}