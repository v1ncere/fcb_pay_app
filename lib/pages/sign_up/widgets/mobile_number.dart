import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../sign_up.dart';

class MobileNumber extends StatelessWidget {
  const MobileNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your mobile number', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            TextFormField(
              controller: state.mobileController,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              keyboardType: TextInputType.phone,
              onChanged: (value) => context.read<SignUpBloc>().add(MobileNumberChanged(value)),
              decoration: InputDecoration(
                filled: true,
                border: const UnderlineInputBorder(),
                label: const Text('Mobile Number'),
                prefix: const Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Text('+63'),
                ),
                prefixStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                ),
                errorText: state.mobile.displayError?.text(),
                suffixIcon: !state.mobile.isPure
                ? IconButton(
                    icon: const Icon(FontAwesomeIcons.xmark),
                    iconSize: 18,
                    onPressed: () => context.read<SignUpBloc>().add(MobileTextErased())
                  )
                : null
              ),
              style: const TextStyle(height: 1.5),
            )
          ]
        );
      }
    );
  }
}