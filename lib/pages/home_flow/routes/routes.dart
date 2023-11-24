import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/account/account.dart';
import 'package:fcb_pay_app/pages/account_add/account_add.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/pages/home_flow/bloc/router_bloc.dart';
import 'package:fcb_pay_app/pages/notifications/notifications.dart';
import 'package:fcb_pay_app/pages/notifications_viewer/notifications_viewer.dart';
import 'package:fcb_pay_app/pages/receipt/receipt.dart';
import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';

List<Page<dynamic>> onGenerateHomePages(HomePageStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    // home
    case HomePageStatus.appBar:
      return [BottomAppbarPage.page()];
    // account page
    case HomePageStatus.account:
      return [BottomAppbarPage.page(), AccountPage.page()];
    case HomePageStatus.accountDynamicViewer:
      return [BottomAppbarPage.page(), AccountPage.page(), DynamicViewerPage.page()];
    case HomePageStatus.accountDynamicViewerReciept:
      return [BottomAppbarPage.page(), AccountPage.page(), DynamicViewerPage.page(), ReceiptPage.page()];
    // dynamic viewer
    case HomePageStatus.dynamicViewer:
      return [BottomAppbarPage.page(), DynamicViewerPage.page()];
    case HomePageStatus.dynamicViewerReceipt:
      return [BottomAppbarPage.page(), DynamicViewerPage.page(), ReceiptPage.page()];
    // scanner transaction
    case HomePageStatus.scannerTransaction:
      return [ScannerTransactionPage.page()];
    case HomePageStatus.scannerTransactionReceipt:
      return [BottomAppbarPage.page(), ScannerTransactionPage.page(), ReceiptPage.page()];
    // add account
    case HomePageStatus.addAccount:
      return [BottomAppbarPage.page(), AccountAddPage.page()];
    // notification
    case HomePageStatus.notifications:
      return [BottomAppbarPage.page(), NotificationPage.page()];
    case HomePageStatus.notificationViewer:
      return [BottomAppbarPage.page(), NotificationPage.page(), NotificationsViewerPage.page()];
  }
}