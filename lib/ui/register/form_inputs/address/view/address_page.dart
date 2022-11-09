import 'package:fcb_pay_app/ui/register/form_inputs/address/bloc/address_bloc.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/address/view/address_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => AddressBloc(),
        child: const AddressForm(),
      ),
    );
  }
}