import 'package:fcb_pay_app/ui/home/tabs/home_tab/widgets/pitakard_balance.dart';
import 'package:fcb_pay_app/ui/home/tabs/home_tab/widgets/wallet_balance.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 70.0, 15.0, 0.0),
        child: Column(
          children: const [
            WalletBalance(),
            SizedBox(height: 5,),
            PitakardBalance(),
          ],
        ),
      )
    );
  }
}