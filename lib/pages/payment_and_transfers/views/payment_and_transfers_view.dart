import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/payment_and_transfers/payment_and_transfers.dart';

class PaymentAndTransfersView extends StatelessWidget {
  const PaymentAndTransfersView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Transfers",
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WidgetTransfer(
                  title: "BILLS PAYMENT",
                  colors: Colors.greenAccent.withOpacity(0.3),
                  methods: () => context.flow<AppStatus>().update((next) => AppStatus.payment),
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
      ),
    );
  }
}