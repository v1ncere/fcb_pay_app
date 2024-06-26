import 'package:flutter/material.dart';

class ScannerErrorText extends StatelessWidget {
  const ScannerErrorText({super.key, required this.area});
  final double area;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          height: area - 10,
          width: area - 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Oops! Something went wrong. Please try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.redAccent[700],
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}