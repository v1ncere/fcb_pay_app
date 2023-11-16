import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/account.dart';
import 'package:fcb_pay_app/pages/account_add/account_add.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/pages/local_authentication/local_authentication.dart';
import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/pages/notifications/notifications.dart';
import 'package:fcb_pay_app/pages/notifications_viewer/notifications_viewer.dart';
import 'package:fcb_pay_app/pages/receipt/receipt.dart';
import 'package:fcb_pay_app/pages/register/register.dart';
import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';
import 'package:fcb_pay_app/splash/splash.dart';

List<Page<dynamic>> onGeneratePages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    // splash
    case AppStatus.splash:
      return [Splash.page()];
    case AppStatus.register:
      return [LoginPage.page(), RegisterPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    // local authentication
    case AppStatus.pin:
      return [AuthPinPage.page()];
    case AppStatus.createPin:
      return [AuthPinPage.page(), CreatePinPage.page()];
    // home
    case AppStatus.authenticated:
      return [BottomAppbarPage.page()];
    // account page
    case AppStatus.account:
      return [BottomAppbarPage.page(), AccountPage.page()];
    case AppStatus.accountDynamicViewer:
      return [BottomAppbarPage.page(), AccountPage.page(), DynamicViewerPage.page()];
    case AppStatus.accountDynamicViewerReciept:
      return [BottomAppbarPage.page(), AccountPage.page(), DynamicViewerPage.page(), ReceiptPage.page()];
    // dynamic viewer
    case AppStatus.dynamicViewer:
      return [BottomAppbarPage.page(), DynamicViewerPage.page()];
    case AppStatus.dynamicViewerReceipt:
      return [BottomAppbarPage.page(), DynamicViewerPage.page(), ReceiptPage.page()];
    // scanner transaction
    case AppStatus.scannerTransaction:
      return [BottomAppbarPage.page(), ScannerTransactionPage.page()];
    case AppStatus.scannerTransactionReceipt:
      return [BottomAppbarPage.page(), ScannerTransactionPage.page(), ReceiptPage.page()];
    // add account
    case AppStatus.addAccount:
      return [BottomAppbarPage.page(), AccountAddPage.page()];
    // notification
    case AppStatus.notifications:
      return [BottomAppbarPage.page(), NotificationPage.page()];
    case AppStatus.notificationViewer:
      return [BottomAppbarPage.page(), NotificationPage.page(), NotificationsViewerPage.page()];
  }
}