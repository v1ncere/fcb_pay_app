import 'package:fcb_pay_app/pages/scanner/scanner.dart';
import 'package:flutter/material.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  static Route<void> route() => MaterialPageRoute<void>(builder: (_) => const ScannerPage());

  @override
  Widget build(BuildContext context) {
    return const ScannerView();
  }
}