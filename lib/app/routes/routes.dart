import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/account.dart';
import 'package:fcb_pay_app/pages/account_fund_transfer/account_fund_transfer.dart';
import 'package:fcb_pay_app/pages/account_payment/account_payment.dart';
import 'package:fcb_pay_app/pages/add_account/add_account.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/pages/scanner/scanner.dart';
import 'package:fcb_pay_app/splash/splash.dart';

List<Page<dynamic>> onGeneratePages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.authenticated:
      return [BottomAppbarPage.page()];
    case AppStatus.account:
      return [
        BottomAppbarPage.page(),
        AccountPage.page()
      ];
    case AppStatus.accountPayment:
      return [
        BottomAppbarPage.page(),
        AccountPage.page(),
        AccountPaymentPage.page()
      ];
    case AppStatus.accountFundTransfer:
      return [
        BottomAppbarPage.page(),
        AccountPage.page(),
        AccountFundTransferPage.page()
      ];
    case AppStatus.fundTransfer:
      return [
        BottomAppbarPage.page(),
        FundTransferPage.page()
      ];
    case AppStatus.payment:
      return [
        BottomAppbarPage.page(),
        PaymentPage.page()
      ];
    case AppStatus.scanner:
      return [
        BottomAppbarPage.page(),
        ScannerPage.page()
      ];
    case AppStatus.scannerTransaction:
      return [
        BottomAppbarPage.page(),
        ScannerPage.page(),
        ScannerTransactionPage.page()
      ];
    case AppStatus.addAccount:
      return [
        BottomAppbarPage.page(),
        AddAccountPage.page()
      ];
    case AppStatus.splash:
      return [Splash.page()];
  }
}