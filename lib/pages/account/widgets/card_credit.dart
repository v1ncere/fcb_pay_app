import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

import 'card_widgets.dart';

class CardCredit extends StatelessWidget {
  const CardCredit({
    super.key,
    required this.cardNumber,
    required this.type,
    required this.cardHolder,
    required this.cardExpiration,
    required this.onTap
  });
  final String cardNumber;
  final String type;
  final String cardHolder;
  final String cardExpiration;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: onTap,
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
                ColorString.zombie,
                ColorString.mountainMeadow,
              ],
              stops: const [
                0.5,
                1.0
              ]
            )
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildLogosBlock(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: buildAccountNumber(value: cardNumber, type: type)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(child: buildDetailsBlock(label: 'CARDHOLDER', value: cardHolder)),
                  Flexible(child: buildDetailsBlock(label: 'VALID THRU', value: cardExpiration)),
                ]
              )
            ]
          )
        )
      )
    ); 
  }
}

// Flexible(
//   child: CircularPercentIndicator(
//     radius: 30.0,
//     lineWidth: 6.0,
//     animation: true,
//     arcType: ArcType.full,
//     arcBackgroundColor: Colors.black12,
//     percent: per,
//     center: Text(
//       "$perString%\nUSED",
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         fontSize: 10,
//         fontWeight: FontWeight.w900,
//         color: CustomColor.mystic
//       )
//     ),
//     circularStrokeCap: CircularStrokeCap.round,
//     progressColor: progressColor(double.parse(perString))
//   )
// )

  // double _percentDecimal(double limit, double bal) {
  //   double def = bal / limit ;
  //   return def.abs();
  // }

  // String _percentString(double limit, double bal) {
  //   double res = (bal / limit) * 100;
  //   return res.abs().toStringAsFixed(2);
  // }

  // Color progressColor(double percent) {
  //   return percent >= 75
  //   ? CustomColor.guardsmanRed
  //   : percent < 75 && percent >= 50
  //     ? CustomColor.blazeOrange
  //     : percent < 50 && percent >= 25
  //       ? CustomColor.lime
  //       : CustomColor.deepSea;
  // }
  // final f = NumberFormat("#,##0.00", "en_US");