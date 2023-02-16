import 'package:flutter/material.dart';

import 'package:fcb_pay_app/ui/register/register.dart';

class MobileNumberPage extends StatelessWidget {
  const MobileNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: MobileNumberForm(),
    );
  }
}