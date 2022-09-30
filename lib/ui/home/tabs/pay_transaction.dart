import 'package:flutter/material.dart';

class PayTransactionTab extends StatelessWidget {
  final int number;
  const PayTransactionTab({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('My number is: $number'),
      ),
    );
  }
}