import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

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
        : CustomElevatedButton(
          buttonColor: const Color(0xFF25C166),
          title: 'Transfer',
          titleColor: Colors.white,
          icon: FontAwesomeIcons.moneyBillTransfer,
          iconColor: Colors.white,
          onPressed: state.isValid
          ? () => context.read<FundTransferBloc>().add(FundTransferSubmitted(account ?? ''))
          : null,
        );
      }
    );
  }
}