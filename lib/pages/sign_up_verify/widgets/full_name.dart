import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import '../sign_up_verify.dart';

class FullName extends StatelessWidget {
  const FullName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpVerifyBloc, SignUpVerifyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Full Name',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    onChanged: (value) => context.read<SignUpVerifyBloc>().add(FirstNameChanged(value)),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      label: const Text('First Name'),
                      errorText: state.firstName.displayError?.text()
                    ),
                    style: const TextStyle(height: 1.5)
                  )
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    onChanged: (value) => context.read<SignUpVerifyBloc>().add(LastNameChanged(value)),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      label: const Text('Last Name'),
                      errorText: state.lastName.displayError?.text()
                    ),
                    style: const TextStyle(height: 1.5)
                  )
                )
              ]
            )
          ]
        );
      }
    );
  }
}
