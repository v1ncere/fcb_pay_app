import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

// Build the top row containing logos
Row buildLogosBlock() {
  return Row(
    children: <Widget>[
      Image.asset(
        AssetString.splashLogo,
        height: 25,
        width: 25,
      ),
      const SizedBox(width: 10),
      CustomText(
        text: 'FIRST CONSOLIDATED BANK',
        color: ColorString.white,
        fontSize: 13,
        fontWeight: FontWeight.bold
      )
    ]
  );
}

Column buildAccountNumber({
  required String value,
  required String type
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      CustomText(
        text: maskedNum(value),
        color: ColorString.white,
        fontSize: 21
      ),
      CustomText(
        text: type.toUpperCase(),
        color: ColorString.white,
        fontSize: 9,
        fontWeight: FontWeight.bold
      )
    ]
  );
}

// Build Column containing the cardholder and expiration information
Column buildDetailsBlock({
  required String label, 
  required String value
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      CustomText(
        text: label.toUpperCase(),
        color: ColorString.catsKillWhite,
        fontSize: 9,
        fontWeight: FontWeight.bold
      ),
      Text(
        value.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorString.catsKillWhite,
          fontWeight: FontWeight.bold,
          fontSize: 15,
          shadows: <Shadow>[
            Shadow(
              color: Colors.black.withOpacity(0.15), // Shadow color
              blurRadius: 1,
              offset: const Offset(0, 1)
            )
          ]
        )
      )
    ]
  );
}

Column mainInfoBlock({
  required String label, 
  required String value
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      CustomText(
        text: label.toUpperCase(),
        color: ColorString.emerald,
        fontSize: 9,
        fontWeight: FontWeight.bold
      ),
      Text(
        value.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorString.eucalyptus,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          shadows: <Shadow>[
            Shadow(
              color: Colors.black.withOpacity(0.15), // Shadow color
              blurRadius: 1,
              offset: const Offset(0, 1)
            )
          ]
        )
      )
    ]
  );
}