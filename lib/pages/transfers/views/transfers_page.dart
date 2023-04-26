import 'package:fcb_pay_app/pages/transfers/transfers.dart';
import 'package:flutter/cupertino.dart';

class TransfersPage extends StatelessWidget {
  const TransfersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: TransfersView(),
    );
  }
}