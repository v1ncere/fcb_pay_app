import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, this.account});
  final String? account;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundTransferBloc, FundTransferState>(
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
        ? const CircularProgressIndicator()
        : ClipRect(
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF009405),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: Colors.white38,
              onTap: () => context.read<FundTransferBloc>().add(FundTransferSubmitted(account ?? '')),
              child: const SizedBox(
                height: 45,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Transfer',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          )
                        ),
                        SizedBox(width: 5),
                        Icon(
                          FontAwesomeIcons.moneyBillTransfer,
                          color: Colors.white,
                          size: 20
                        )
                      ]
                    )
                  )
                )
              )
            )
          )
        );
      }
    );
  }
}