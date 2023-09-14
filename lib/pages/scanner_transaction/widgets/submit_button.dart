import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScannerTransactionBloc, ScannerTransactionState>(
      listenWhen: (previous, current) => previous.formStatus != current.formStatus,
      listener: (context, state) {
        if(state.formStatus.isSuccess) {
          context.flow<AppStatus>().update((next) => AppStatus.scannerTransactionReceipt);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar("Payment sent!", FontAwesomeIcons.solidCircleCheck,Colors.white));
        }
        if(state.formStatus.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(state.message, FontAwesomeIcons.triangleExclamation,Colors.red));
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
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            elevation: MaterialStateProperty.all(2),
            backgroundColor: MaterialStateProperty.all(const Color(0xFF25C166)) 
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