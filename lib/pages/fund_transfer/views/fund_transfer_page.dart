import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';

class FundTransferPage extends StatelessWidget {
  const FundTransferPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: FundTransferPage());

  @override
  Widget build(BuildContext context) {
    return const FundTransferView();
  }
}