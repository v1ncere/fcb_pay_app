import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/functions/phone_number_formatter.dart';
import 'package:fcb_pay_app/pages/register/register.dart';

class MobileNumberForm extends StatelessWidget {
  const MobileNumberForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
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
      ),
    );
  }
}

class _MobileNumberInput extends StatelessWidget {
  final PhoneNumberFormatter phoneNumberFormatter = PhoneNumberFormatter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsBloc, InputsState>(
      buildWhen: (previous, current) => previous.mobileNumber != current.mobileNumber,
      builder: (context, state) {
        return TextField(
          inputFormatters: [phoneNumberFormatter],
          key: const Key('mobile_number_textfield'),
          onChanged: (mobile) => context.read<InputsBloc>().add(MobileNumberChanged(mobile)),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Mobile number',
            errorText: state.mobileNumber.displayError?.text(),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InputsBloc, InputsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
              key: const Key('mobile_submit_elevated_button'),
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: state.isValid
                ? () => context.read<InputsBloc>().add(FormSubmitted())
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
          key: const Key('mobile_cancel_elevated_button'),
          onPressed: context.read<StepperCubit>().stepCancelled,
          child: const Text('BACK'),
        );
      },
    );
  }
}