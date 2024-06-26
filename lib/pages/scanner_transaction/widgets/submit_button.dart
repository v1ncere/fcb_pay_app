import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../home_flow/home_flow.dart';
import '../scanner_transaction.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScannerTransactionBloc, ScannerTransactionState>(
      listenWhen: (previous, current) => previous.formStatus != current.formStatus,
      listener: (context, state) {
        if(state.formStatus.isSuccess) {
          context.flow<HomeRouterStatus>().update((next) => HomeRouterStatus.scannerTransactionReceipt);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: 'Payment sent!',
            icon: FontAwesomeIcons.solidCircleCheck,
            backgroundColor: ColorString.eucalyptus,
            foregroundColor: ColorString.mystic,
          ));
        }
        if(state.formStatus.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: state.message, 
            icon: FontAwesomeIcons.triangleExclamation,
            backgroundColor: ColorString.guardsmanRed,
            foregroundColor: ColorString.mystic,
          ));
        }
      },
      buildWhen: (previous, current) => previous.formStatus != current.formStatus || current.isValid,
      builder: (context, state) {
        return state.formStatus.isInProgress
        ? const CircularProgressIndicator()
        : ElevatedButton(
          onPressed: state.isValid
          ? () => context.read<ScannerTransactionBloc>().add(ScannerTransactionSubmitted())
          : null,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
            elevation: WidgetStateProperty.all(2),
            backgroundColor: WidgetStateProperty.all(const Color(0xFF25C166)) 
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('PAY',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 5),
              Icon(
              FontAwesomeIcons.coins, 
                color: Colors.white,
                size: 20
              )
            ]
          )
        );
      }
    );
  }
}