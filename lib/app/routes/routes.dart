import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/accounts/accounts.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_payment/bottom_appbar_payment.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_settings/bottom_appbar_settings.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/pages/scanner/scanner.dart';
import 'package:fcb_pay_app/splash/splash.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages
) {
  switch (state) {
    case AppStatus.unauthenticated:                                               // [login page]
      return [LoginPage.page()];
    case AppStatus.authenticated:                                                 // [home display page] (The bottom app bar)
      return [BottomAppbarPage.page()];
    case AppStatus.accounts:                                                      // home display page <= [accounts page]
      return [BottomAppbarPage.page(), AccountsPage.page()];
    case AppStatus.accountPayment:                                                // home display page <= account page <= [payment page]
      return [BottomAppbarPage.page(), AccountsPage.page(), PaymentPage.page()];
    case AppStatus.payment:                                                       // home display page <= [bottom payment page]
      return [BottomAppbarPage.page(), BottomAppbarPaymentPage.page()];
    case AppStatus.scanner:                                                       // home display page <= [scanner page]
      return [BottomAppbarPage.page(), ScannerPage.page()];
    case AppStatus.scannerTransaction:                                            // home display page <= scanner page <= [scanner transaction page]
      return [BottomAppbarPage.page(), ScannerPage.page(), ScannerTransactionPage.page()];
    case AppStatus.addAccount:                                                    // home display page <= settings page <= [add account page]
      return [BottomAppbarPage.page(), AddAccountPage.page()];
    case AppStatus.accountFundTransfer:                                           // home display page <= account page <= [fund transfer page]
      return [BottomAppbarPage.page(), AccountsPage.page(), FundTransferPage.page()];
    case AppStatus.splash:                                                        // [splash display]
      return [Splash.page()];
  }
}