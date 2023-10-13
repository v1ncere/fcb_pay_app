import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class AccountCardInfo extends StatelessWidget {
  const AccountCardInfo({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerTransactionBloc, ScannerTransactionState> (
      builder: (context, state) {
        final f = NumberFormat("#,##0.00", "en_US");
        final account = state.account;
        return account.isNotEmpty
        ? Card(
          elevation: 2.0,
          margin: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          color:const Color(0xFF25C166),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/bg.png"),
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
                fit: BoxFit.cover
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRowText(
                    title: 'Balance',
                    titleColor: Colors.white,
                    contentColor: Colors.white,
                    content: f.format(account.balance),
                  ),
                  account.type.toLowerCase() == 'cc'
                  ? CustomRowText(
                    title: 'Used amount',
                    titleColor: Colors.white,
                    contentColor: Colors.white,
                    content: f.format( _usedAmount(account.creditLimit!, account.balance)),
                  ) : const SizedBox.shrink(),
                  account.type.toLowerCase() == 'cc'
                  ? CustomRowText(
                    title: 'Credit Limit',
                    titleColor: Colors.white,
                    contentColor: Colors.white,
                    content: f.format(account.creditLimit),
                  ) : const SizedBox.shrink(),
                  const SizedBox(height: 20),
                  account.type.isNotEmpty
                  ? CustomRowText(
                    title: account.type.toUpperCase(),
                    titleColor: Colors.white,
                    contentColor: Colors.white,
                    content: account.keyId!.replaceRange(0,  account.keyId!.length - 4, '***'),
                    contentFontSize: 12,
                  ) : const SizedBox.shrink(),
                  account.type.toLowerCase() == 'cc'
                  ? CustomRowText(
                    title: 'expiry',
                    titleColor: Colors.white,
                    titleFontSize: 12,
                    contentColor: Colors.white,
                    content: getDateString(account.expiry!),
                    contentFontWeight: FontWeight.w900,
                    contentFontSize: 12,
                  ) : const SizedBox.shrink()
                ]
              )
            )
          )
        )
        : const SizedBox.shrink();
      }
    );
  }

  double _usedAmount(double num1, double num2) {
    double def = 0.0;
    def = num1 - num2;
    return def.abs();
  }
}