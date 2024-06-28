import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../sign_up_verify.dart';

class DateOfBirth extends StatelessWidget {
  const DateOfBirth({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SignUpVerifyBloc, SignUpVerifyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Date of Birth'),
            const SizedBox(height: 10),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                CustomDateTextFormatter(),
              ],
              keyboardType: TextInputType.datetime,
              controller: state.birthdateController,
              decoration: InputDecoration(
                filled: true,
                label: const Text('Date of Birth (dd/mm/yyyy)'),
                suffixIcon: IconButton(
                  onPressed: () async => await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now()
                  ).then((value) {
                    context.read<SignUpVerifyBloc>().add(BirthDateChanged(value ?? DateTime.now()));
                  }),
                  icon: const Icon(FontAwesomeIcons.calendar)
                )
              ),
              style: const TextStyle(height: 1.5),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                final regExp = RegExp(r'^(0[1-9]|1\d|2\d|3[01])/(0[1-9]|1[0-2])/(19[5-9]\d|20\d{2})$');
                return value?.isEmpty == true
                  ? 'date is required'
                  : regExp.hasMatch(value!)
                    ? null
                    : 'invalid date';
              },
              onChanged: (value) => context.read<SignUpVerifyBloc>().add(BirthDateChanged(DateTime.parse(value)))
            )
          ]
        );
      }
    );
  }
}

