import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

Text noteText() {
  return Text(
    TextString.registrationNote,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.teal,
      fontWeight: FontWeight.bold,
      fontSize: 12,
      shadows: <Shadow>[
        Shadow(
          color: Colors.black.withOpacity(0.1), // Shadow color
          blurRadius: 1,
          offset: const Offset(0, 1)
        )
      ]
    )
  );
}