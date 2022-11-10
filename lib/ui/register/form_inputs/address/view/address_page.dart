import 'package:fcb_pay_app/ui/register/form_inputs/address/view/address_form.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: AddressForm(),
    );
  }
}