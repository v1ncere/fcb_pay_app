import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/transfers/transfers.dart';

class TransfersView extends StatelessWidget {
  const TransfersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfers",
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.w700
          ),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WidgetTransfer(
                title: "PITAKARD TRANSFER",
                colors: Colors.greenAccent.withOpacity(0.3),
                methods: () {},
                text: "Transfering to your pitakard will become rich.",
              ),
              PesoTransfer(
                colors: Colors.amberAccent.withOpacity(0.3),
                methods: () {},
                text: "This will create data collection creating signus",
              ),
              WidgetTransfer(
                title: "FUND TRANSFER",
                colors: Colors.greenAccent.withOpacity(0.3),
                methods: () {},
                text: "You are serious neggas transferring tru peso.",
              ),
            ]
          ),
      ),
    );
  }
}