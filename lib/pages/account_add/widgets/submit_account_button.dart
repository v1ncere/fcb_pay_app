import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/account_add/account_add.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class SubmitAccountButton extends StatelessWidget {
  const SubmitAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountAddBloc, AccountAddState>(
      listenWhen: (previous, current) => previous.formStatus != current.formStatus,
      listener: (context, state) {
        if(state.formStatus.isSuccess) {
          Navigator.of(context).pop(); // pop the navigator
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            "Account Request Successful!",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white
          ));
        }
        if(state.formStatus.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            state.message,
            FontAwesomeIcons.triangleExclamation,
            Colors.red
          ));
        }
      },
      buildWhen: (previous, current) => previous.formStatus != current.formStatus || current.isValid,
      builder: (context, state) {
        return state.formStatus.isInProgress
        ? const CircularProgressIndicator()
        : ElevatedButton(
          key: const Key('add_account_submit_button'),
          style: ElevatedButton.styleFrom(elevation: 2),
          onPressed: () {
            context.read<AccountAddBloc>().add(AccountStatusRefresher());
            context.read<AccountAddBloc>().add(AccountFormSubmitted());
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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