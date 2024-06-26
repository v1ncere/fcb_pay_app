import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import '../account_add.dart';

class FullName extends StatelessWidget {
  const FullName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountAddBloc, AccountAddState>(
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
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      label: const Text('First Name'),
                      errorText: state.firstName.displayError?.text()
                    ),
                    style: const TextStyle(height: 1.5),
                    onChanged: (value) => context.read<AccountAddBloc>().add(FirstNameChanged(value)),
                  )
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      label: const Text('Last Name'),
                      errorText: state.lastName.displayError?.text()
                    ),
                    style: const TextStyle(height: 1.5),
                    onChanged: (value) => context.read<AccountAddBloc>().add(LastNameChanged(value)),
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