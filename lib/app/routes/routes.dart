import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/account.dart';
import 'package:fcb_pay_app/pages/account_fund_transfer/account_fund_transfer.dart';
import 'package:fcb_pay_app/pages/account_payment/account_payment.dart';
import 'package:fcb_pay_app/pages/account_register/account_register.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_nav/bottom_appbar_nav.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/pages/notifications/notifications.dart';
import 'package:fcb_pay_app/pages/notifications_viewer/notifications_viewer.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/pages/receipt/receipt.dart';
import 'package:fcb_pay_app/pages/receipt/views/receipt_page.dart';
import 'package:fcb_pay_app/pages/register/register.dart';
import 'package:fcb_pay_app/pages/scanner/scanner.dart';
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
      return [BottomAppbarNavPage.page()];
    case AppStatus.account:
      return [BottomAppbarNavPage.page(), AccountPage.page()];
    case AppStatus.accountPayment:
      return [BottomAppbarNavPage.page(), AccountPage.page(), AccountPaymentPage.page()];
    case AppStatus.accountPaymentReceipt:
      return [ BottomAppbarNavPage.page(), AccountPage.page(), AccountPaymentPage.page(), ReceiptPage.page()];
    case AppStatus.accountFundTransfer:
      return [BottomAppbarNavPage.page(), AccountPage.page(), AccountFundTransferPage.page()];
    case AppStatus.accountFundTransferReceipt:
      return [ BottomAppbarNavPage.page(), AccountPage.page(), AccountFundTransferPage.page(), ReceiptPage.page()];
    case AppStatus.fundTransfer:
      return [BottomAppbarNavPage.page(), FundTransferPage.page()];
    case AppStatus.fundTransferReceipt:
      return [BottomAppbarNavPage.page(), FundTransferPage.page(), ReceiptPage.page()];
    case AppStatus.payment:
      return [BottomAppbarNavPage.page(), PaymentPage.page()];
    case AppStatus.paymentReceipt:
      return [BottomAppbarNavPage.page(), PaymentPage.page(), ReceiptPage.page()];
    case AppStatus.scanner:
      return [BottomAppbarNavPage.page(), ScannerPage.page()];
    case AppStatus.scannerTransaction:
      return [BottomAppbarNavPage.page(), ScannerPage.page(), ScannerTransactionPage.page()];
    case AppStatus.scannerTransactionReceipt:
      return [BottomAppbarNavPage.page(), ScannerPage.page(), ScannerTransactionPage.page(), ReceiptPage.page()];
    case AppStatus.addAccount:
      return [BottomAppbarNavPage.page(), AccountRegisterPage.page()];
    case AppStatus.notifications:
      return [BottomAppbarNavPage.page(), NotificationPage.page()];
    case AppStatus.notificationViewer:
      return [BottomAppbarNavPage.page(), NotificationPage.page(), NotificationsViewerPage.page()];
  }
}