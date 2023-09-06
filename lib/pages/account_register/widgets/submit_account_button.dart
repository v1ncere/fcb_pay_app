import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/account_register/account_register.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class SubmitAccountButton extends StatelessWidget {
  const SubmitAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountRegisterBloc, AccountRegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if(state.status.isSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            "Account Added!",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white
          ));
        }
        if(state.status.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            "Something went wrong!",
            FontAwesomeIcons.triangleExclamation,
            Colors.red
          ));
        }
      },
      buildWhen: (previous, current) =>
        previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
        ? const CircularProgressIndicator()
        : ElevatedButton(
          key: const Key('add_account_submit_button'),
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: state.isValid
            ? () => context.read<AccountRegisterBloc>().add(AccountFormSubmitted())
            : null,
          child: const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Text('Submit', style: TextStyle(fontWeight: FontWeight.w700),),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.paperPlane)
              ]
            )
          )
        );
      }
    );
  }
}