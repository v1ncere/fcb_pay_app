import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/pages/payment_and_transfers/payment_and_transfers.dart';
import 'package:fcb_pay_app/pages/scanner/scanner.dart';
import 'package:fcb_pay_app/splash/splash.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages
) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.authenticated:
      return [BottomAppbarPage.page()];
    case AppStatus.scanner:
      return [BottomAppbarPage.page(), ScannerPage.page()];
    case AppStatus.scannerTransaction:
      return [BottomAppbarPage.page(), ScannerPage.page(), ScannerTransactionPage.page()];
    case AppStatus.payment:
      return [BottomAppbarPage.page(), PaymentPage.page()];
    case AppStatus.addAccount:
      return [BottomAppbarPage.page(), AddAccountPage.page()];
    case AppStatus.splash:
      return [Splash.page()];
  }
}