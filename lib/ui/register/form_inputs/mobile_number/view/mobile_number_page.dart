import 'package:flutter/material.dart';

import 'package:fcb_pay_app/ui/register/form_inputs/mobile_number/view/mobile_number_form.dart';

class MobileNumberPage extends StatelessWidget {
  const MobileNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: MobileNumberForm(),
    );
  }
}