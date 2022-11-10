import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/ui/register/form_inputs/bloc/inputs_bloc.dart';
import 'package:fcb_pay_app/ui/register/stepper/cubit/stepper_cubit.dart';

class MobileNumberForm extends StatelessWidget {
  const MobileNumberForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _MobileNumberInput(),
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

class _MobileNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsBloc, InputsState>(
      buildWhen: (previous, current) => previous.mobileNumber != current.mobileNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('address_postCodeInput_textField'),
          onChanged: (value) => context.read<InputsBloc>().add(PostCodeChanged(value)),
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
    return BlocBuilder<InputsBloc, InputsState>(
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
    return BlocBuilder<InputsBloc, InputsState>(
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