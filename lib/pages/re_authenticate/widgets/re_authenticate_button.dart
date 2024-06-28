import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../re_authenticate.dart';
import '../../../utils/utils.dart';

class ReAuthenticateButton extends StatelessWidget {
  const ReAuthenticateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReAuthBloc, ReAuthState>(
      builder: (context, state) {
        return state.status.isInProgress
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(strokeWidth: 3)
              )
            )
          )
        : ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20
            ),
            foregroundColor: ColorString.deepSea,
            backgroundColor: ColorString.turbo,
            shape: const CircleBorder(side: BorderSide.none),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
            )
          ),
          onPressed: state.isValid
          ? () => context.read<ReAuthBloc>().add(ReAuthenticatedWithCredentials())
          : null,
          child: const Icon(FontAwesomeIcons.rightToBracket)
        );
      }
    );
  }
}