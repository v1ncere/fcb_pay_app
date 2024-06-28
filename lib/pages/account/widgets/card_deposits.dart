import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

import 'card_widgets.dart';

class DepositsCard extends StatelessWidget {
  const DepositsCard({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.type,
    required this.onTap
  });
  final String cardNumber;
  final String cardHolder;
  final String type;
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[ 
                  buildDetailsBlock(label: 'CARDHOLDER', value: cardHolder),
                ]
              )
            ]
          )
        )
      )
    );
  }
}
