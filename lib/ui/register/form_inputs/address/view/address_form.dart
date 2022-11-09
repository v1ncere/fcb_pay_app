import 'package:fcb_pay_app/ui/register/form_inputs/address/bloc/address_bloc.dart';
import 'package:fcb_pay_app/ui/register/stepper/cubit/stepper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _HomeAddressInput(),
          const SizedBox(height: 12.0),
          _PostCodeInput(),
          const SizedBox(height: 12.0),
          Row(
            children: [
              _SubmitButton(),
              const SizedBox(width: 8.0),
              _CancelButton(),
            ],
          )
        ]
      ),
    );
  }
}

class _HomeAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      buildWhen: (previous, current) => previous.homeAddress != current.homeAddress,
      builder: (context, state) {
        return TextField(
          key: const Key('address_homeAdressInput_textField'),
          onChanged: (value) => context.read<AddressBloc>().add(HomeAddressChanged(value)),
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Home Address',
            errorText: state.homeAddress.invalid ? state.homeAddress.error?.message : null,
          ),
        );
      },
    );
  }
}

class _PostCodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      buildWhen: (previous, current) => previous.postCode != current.postCode,
      builder: (context, state) {
        return TextField(
          key: const Key('address_postCodeInput_textField'),
          onChanged: (value) => context.read<AddressBloc>().add(PostCodeChanged(value)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Postcode',
            errorText: state.postCode.invalid ? state.postCode.error?.message : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('addressForm_submitButton_elevatedButton'),
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: state.status.isValidated
            ? context.read<StepperCubit>().stepContinued
            : null,
          child: const Text('SUBMIT'),
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextButton(
          key: const Key('addressForm_cancelButton_elevatedButton'),
          onPressed: () => context.read<StepperCubit>().stepCancelled,
          child: const Text('CANCEL'),
        );
      },
    );
  }
}