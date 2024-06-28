import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../sign_up_verify.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorString.eucalyptus,
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
      ),
      onPressed: () => context.read<SignUpVerifyBloc>().add(VerifyButtonSubmitted()),
      child: Text(
        'Submit',
        style: TextStyle(
          color: ColorString.white
        )
      )
    );
  }
}