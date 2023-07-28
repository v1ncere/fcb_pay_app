import 'package:flutter/material.dart';

class ScannerText extends StatelessWidget {
  const ScannerText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Scan QR Code",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontWeight: FontWeight.w900
            )
          )
        ]
      )
    );
  }
}