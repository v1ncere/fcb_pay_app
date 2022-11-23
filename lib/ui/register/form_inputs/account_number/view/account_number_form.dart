import 'package:fcb_pay_app/ui/register/form_inputs/account_number/models/account_number_formatter.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/bloc/inputs_bloc.dart';
import 'package:fcb_pay_app/ui/register/stepper/cubit/stepper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountNumberForm extends StatelessWidget {
  const AccountNumberForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //_HomeAddressInput(),
          // const SizedBox(height: 12.0),
          _AccountNumberInput(),
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

// class _HomeAddressInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<InputsBloc, InputsState>(
//       buildWhen: (previous, current) => previous.homeAddress != current.homeAddress,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('address_homeAdressInput_textField'),
//           onChanged: (value) => context.read<InputsBloc>().add(HomeAddressChanged(value)),
//           keyboardType: TextInputType.streetAddress,
//           decoration: InputDecoration(
//             border: const OutlineInputBorder(),
//             labelText: 'Home Address',
//             errorText: state.homeAddress.invalid ? state.homeAddress.error?.message : null,
//           ),
//         );
//       },
//     );
//   }
// }

class _AccountNumberInput extends StatelessWidget {
  final AccountsInputFormatter accountsInputFormatter = AccountsInputFormatter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsBloc, InputsState>(
      buildWhen: (previous, current) => previous.accountNumber != current.accountNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('account_number_textfield'),
          inputFormatters: [accountsInputFormatter],
          onChanged: (value) => context.read<InputsBloc>().add(AccountNumberChanged(value)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Account Number',
            errorText: state.accountNumber.invalid ? state.accountNumber.error?.message : null,
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
          key: const Key('account_number_submit_elevated_button'),
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: context.read<StepperCubit>().stepContinued,
          child: const Text('NEXT'),
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
          key: const Key('account_number_cancel_elevated_button'),
          onPressed: context.read<StepperCubit>().stepCancelled,
          child: const Text('BACK'),
        );
      },
    );
  }
}