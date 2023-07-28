import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScannerTransactionBloc,ScannerTransactionState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if(state.status.isSuccess) {
          context.flow<AppStatus>().update((next) => AppStatus.authenticated);
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            "Payment sent!",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white,
          ));
        }
        if(state.status.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            "Something went wrong!",
            FontAwesomeIcons.triangleExclamation,
            Colors.red,
          ));
        }
      },
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
        ? const CircularProgressIndicator()
        : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRect(
              child: Material(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF009405),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.white38,
                  onTap: state.isValid
                    ? () => context.read<ScannerTransactionBloc>().add(ScannerTransactionSubmitted())
                    : null,
                  child: const SizedBox(
                    height: 45,
                    width: 75,
                    child: Row(
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
                          size: 20,
                        )
                      ]
                    )
                  )
                )
              )
            )
          ]
        );
      }
    );
  }
}