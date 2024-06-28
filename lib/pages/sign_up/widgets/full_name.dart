import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../bloc/sign_up_bloc.dart';
import '../sign_up.dart';

class FullName extends StatelessWidget {
  const FullName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Full Name', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: state.firstNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      label: const Text('First'),
                      errorText: state.firstName.displayError?.text(),
                      suffixIcon: !state.firstName.isPure
                      ? IconButton(
                          icon: const Icon(FontAwesomeIcons.xmark),
                          iconSize: 18,
                          onPressed: () => context.read<SignUpBloc>().add(FirstNameTextErased())
                        )
                      : null
                    ),
                    onChanged: (value) => context.read<SignUpBloc>().add(FirstNameChanged(value))
                  )
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: state.lastNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      label: const Text('Last'),
                      errorText: state.lastName.displayError?.text(),
                      suffixIcon: !state.lastName.isPure 
                      ? IconButton(
                          icon: const Icon(FontAwesomeIcons.xmark),
                          iconSize: 18,
                          onPressed: () => context.read<SignUpBloc>().add(LastNameTextErased())
                        )
                      : null
                    ),
                    onChanged: (value) => context.read<SignUpBloc>().add(LastNameChanged(value))
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