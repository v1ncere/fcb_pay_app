import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../home_flow/home_flow.dart';
import '../home.dart';
import 'widgets.dart';

Card creditCard({
  required BuildContext context,
  required List<Account> accountList,
  required Account account
}) {
  final limit = account.creditLimit!;
  final bal = account.balance!;
  return Card(
    elevation: 2.0,
    color: ColorString.eucalyptus,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(AssetString.splashLogo),
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
          fit: BoxFit.cover
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            ColorString.mountainMeadow,
            ColorString.zombie,
          ],
          stops: const [
            0.5,
            1.0
          ]
        )
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CREDIT',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: ColorString.white
                      )
                    ),
                    settingsPopUp(
                      accountList: accountList,
                      category: account.category,
                      onSelected: (value) {
                        context.read<AccountsHomeBloc>().add(CreditDisplayChanged(value));
                      }
                    )
                  ]
                ),
                const Divider(color: Colors.white30)
              ]
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                context.read<RouterBloc>().add(RouterAccountsPassed(account));
                context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.account); // navigate to other page
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildAccountNumber(value: account.accountKeyID!, type: account.type),
                      Icon(FontAwesomeIcons.chevronRight, size: 18, color: ColorString.white)
                    ]
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildDetailsBlock(label: 'OUTSTANDING BALANCE', value: Currency.fmt.format(bal)),
                          const SizedBox(height: 10),
                          buildDetailsBlock(label: 'AVAILABLE CREDIT', value: Currency.fmt.format(_availableCredit(limit, bal))),
                          const SizedBox(height: 10),
                          buildDetailsBlock(label: 'CREDIT LIMIT', value: Currency.fmt.format(limit))
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
                ]
              )
            )
          ]
        )
      ),
    )
  );
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