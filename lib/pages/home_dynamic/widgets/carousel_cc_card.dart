import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class CarouselCCCard extends StatelessWidget {
  const CarouselCCCard({
    super.key,
    required this.keyId,
    required this.type,
    required this.ownerId,
    required this.balance,
    required this.creditLimit,
    required this.expiry
  });
  final String keyId;
  final String type;
  final String ownerId;
  final double balance;
  final double creditLimit;
  final DateTime expiry;

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("#,##0.00", "en_US");
    return Card(
      elevation: 2.0,
      clipBehavior: Clip.antiAlias,
      color:const Color(0xFF25C166),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/bg.png"),
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
              fit: BoxFit.cover
            )
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRowText(
                      title: 'Balance',
                      titleColor: Colors.white,
                      contentColor: Colors.white,
                      content: f.format(balance),
                    ),
                    CustomRowText(
                      title: 'Used amount',
                      titleColor: Colors.white,
                      contentColor: Colors.white,
                      content: f.format( _usedAmount(creditLimit, balance)),
                    ),
                    CustomRowText(
                      title: 'Credit Limit',
                      titleColor: Colors.white,
                      contentColor: Colors.white,
                      content: f.format(creditLimit),
                    ),
                  ]
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRowText(
                      title: type.toUpperCase(),
                      titleColor: Colors.white,
                      contentColor: Colors.white,
                      content: 'expiry',
                      contentFontSize: 12,
                    ),
                    CustomRowText(
                      title: keyId.replaceRange(0, keyId.length - 4, '***'),
                      titleColor: Colors.white,
                      titleFontSize: 12,
                      contentColor: Colors.white,
                      content: getDateString(expiry),
                      contentFontWeight: FontWeight.w900,
                      contentFontSize: 12,
                    )
                  ]
                )
              ]
            )
          )
        ),
        onTap: () {
          context.read<AppBloc>().add(AccountArgumentPassed(keyId)); // bloc events for passing args
          context.flow<AppStatus>().update((state) => AppStatus.account);
        }
      )
    );
  }

  double _usedAmount(double num1, double num2) {
    double def = 0.0;
    def = num1 - num2;
    return def.abs();
  }
}