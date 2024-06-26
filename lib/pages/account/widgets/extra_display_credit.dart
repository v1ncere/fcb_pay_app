import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

import 'widgets.dart';

class ExtraDisplayCredit extends StatelessWidget {
  const ExtraDisplayCredit({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    final limit = account.creditLimit!;
    final bal = account.balance!;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          mainInfoBlock(label: 'OUTSTANDING BALANCE', value: Currency.fmt.format(bal)),
          const SizedBox(height: 30),
          Card(
            elevation: 2.0,
            color: ColorString.emerald, 
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetailsBlock(label: 'AVAILABLE CREDIT', value: Currency.fmt.format(_availableCredit(limit, bal))),
                      const SizedBox(height: 20),
                      buildDetailsBlock(label: 'CREDIT LIMIT', value: Currency.fmt.format(limit)),
                    ]
                  ),
                  Flexible(
                    child: CircularPercentIndicator(
                      radius: 50.0,
                      lineWidth: 8.0,
                      animation: true,
                      arcType: ArcType.full,
                      arcBackgroundColor: Colors.black12,
                      percent: _percentDecimal(limit, bal),
                      center: Text(
                        '${_percentString(limit, bal)}%\nUSED',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: ColorString.white,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 1,
                              offset: const Offset(0, 1)
                            )
                          ]
                        )
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: _progressColor(double.parse(_percentString(limit, bal)))
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}

// METHODS ==========================================
// ==================================================

double _availableCredit(double limit, double bal) {
  return limit - bal;
}

double _percentDecimal(double limit, double bal) {
  double def = bal / limit ;
  return def.abs();
}

String _percentString(double limit, double bal) {
  double res = (bal / limit) * 100;
  return res.abs().toStringAsFixed(2);
}

Color _progressColor(double percent) {
  return percent >= 75
  ? ColorString.guardsmanRed
  : percent < 75 && percent >= 50
    ? ColorString.blazeOrange
    : percent < 50 && percent >= 25
      ? ColorString.lime
      : ColorString.deepSea;
}