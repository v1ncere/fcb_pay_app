import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/account.dart';
import 'package:fcb_pay_app/pages/account_fund_transfer/account_fund_transfer.dart';
import 'package:fcb_pay_app/pages/account_payment/account_payment.dart';
import 'package:fcb_pay_app/pages/account_register/account_register.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/pages/notifications/notifications.dart';
import 'package:fcb_pay_app/pages/notifications_viewer/notifications_viewer.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/pages/receipt/receipt.dart';
import 'package:fcb_pay_app/pages/register/register.dart';
import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';
import 'package:fcb_pay_app/splash/splash.dart';

List<Page<dynamic>> onGeneratePages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.splash:
      return [Splash.page()];
    case AppStatus.register:
      return [LoginPage.page(), RegisterPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.authenticated:
      return [BottomAppbarPage.page()];
    case AppStatus.account:
      return [BottomAppbarPage.page(), AccountPage.page()];
    case AppStatus.accountPayment:
      return [BottomAppbarPage.page(), AccountPage.page(), AccountPaymentPage.page()];
    case AppStatus.accountPaymentReceipt:
      return [ BottomAppbarPage.page(), AccountPage.page(), AccountPaymentPage.page(), ReceiptPage.page()];
    case AppStatus.accountFundTransfer:
      return [BottomAppbarPage.page(), AccountPage.page(), AccountFundTransferPage.page()];
    case AppStatus.accountFundTransferReceipt:
      return [ BottomAppbarPage.page(), AccountPage.page(), AccountFundTransferPage.page(), ReceiptPage.page()];
    case AppStatus.fundTransfer:
      return [BottomAppbarPage.page(), FundTransferPage.page()];
    case AppStatus.fundTransferReceipt:
      return [BottomAppbarPage.page(), FundTransferPage.page(), ReceiptPage.page()];
    case AppStatus.payment:
      return [BottomAppbarPage.page(), PaymentPage.page()];
    case AppStatus.paymentReceipt:
      return [BottomAppbarPage.page(), PaymentPage.page(), ReceiptPage.page()];
    // case AppStatus.scanner:
    //   return [BottomAppbarPage.page(), ScannerPage.page()];
    case AppStatus.scannerTransaction:
      return [BottomAppbarPage.page(), ScannerTransactionPage.page()];
    case AppStatus.scannerTransactionReceipt:
      return [BottomAppbarPage.page(), ScannerTransactionPage.page(), ReceiptPage.page()];
    case AppStatus.addAccount:
      return [BottomAppbarPage.page(), AccountRegisterPage.page()];
    case AppStatus.notifications:
      return [BottomAppbarPage.page(), NotificationPage.page()];
    case AppStatus.notificationViewer:
      return [BottomAppbarPage.page(), NotificationPage.page(), NotificationsViewerPage.page()];
  }
}