import 'package:fcb_pay_app/ui/scanner/widgets/scanner_widget.dart';
import 'package:flutter/cupertino.dart';

class Scanner extends StatelessWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ScannerWidget(),
    );
  }
}