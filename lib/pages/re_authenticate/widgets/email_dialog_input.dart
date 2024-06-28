import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';
import '../re_authenticate.dart';

class EmailDialogInput extends StatelessWidget {
  const EmailDialogInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReAuthBloc, ReAuthState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          clipBehavior: Clip.antiAlias,
          onChanged: (email) => context.read<ReAuthBloc>().add(ReAuthEmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 211, 243, 224),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(FontAwesomeIcons.solidCircleUser),
            labelText: 'Email',
            errorText: state.email.displayError?.text(),
            border: SelectedInputBorderWithShadow(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            )
          )
        );
      }
    );
  }
}