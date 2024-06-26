import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../account_add.dart';

class SubmitAccountButton extends StatelessWidget {
  const SubmitAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountAddBloc, AccountAddState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.solidCircleCheck,
            backgroundColor: ColorString.eucalyptus,
            foregroundColor: ColorString.mystic
          ));
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
        if(state.formStatus.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.triangleExclamation,
            backgroundColor: ColorString.guardsmanRed,
            foregroundColor: ColorString.mystic
          ));
        }
      },
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorString.eucalyptus,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
        onPressed: () => context.read<AccountAddBloc>().add(AccountFormSubmitted()),
        child: Text(
          'Submit',
          style: TextStyle(
            color: ColorString.white
          )
        )
      )
    );
  }
}