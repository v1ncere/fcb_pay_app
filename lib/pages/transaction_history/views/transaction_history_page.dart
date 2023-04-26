import 'package:fcb_pay_app/pages/transaction_history/transaction_history.dart';
import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: TransactionHistoryView()
    );
  }
}