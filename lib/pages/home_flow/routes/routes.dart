import 'package:flutter/material.dart';

import '../../account/account.dart';
import '../../account_add/account_add.dart';
import '../../bottom_navbar/bottom_navbar.dart';
import '../../dynamic_viewer/dynamic_viewer.dart';
import '../../notifications/notifications.dart';
import '../../notifications_viewer/notifications_viewer.dart';
import '../../re_authenticate/re_authenticate.dart';
import '../../receipt/receipt.dart';
import '../../scanner_transaction/scanner_transaction.dart';
import '../../settings/settings.dart';
import '../../update_password/update_password.dart';
import '../bloc/router_bloc.dart';

List<Page<dynamic>> onGenerateHomePages(HomeRouterStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    // HOME
    case HomeRouterStatus.appBar:
      return [BottomNavbarPage.page()];
    
    // ACCOUNT PAGE
    case HomeRouterStatus.account:
      return [BottomNavbarPage.page(), AccountPage.page()];
    case HomeRouterStatus.accountsViewer:
      return [BottomNavbarPage.page(), AccountPage.page(), DynamicViewerPage.page()];
    case HomeRouterStatus.accountsViewerReciept:
      return [BottomNavbarPage.page(), AccountPage.page(), DynamicViewerPage.page(), ReceiptPage.page()];

    // PAYMENTS
    case HomeRouterStatus.paymentsView:
      return [BottomNavbarPage.page(), DynamicViewerPage.page()];
    case HomeRouterStatus.paymentsReceipt:
      return [BottomNavbarPage.page(), DynamicViewerPage.page(), ReceiptPage.page()];
    
    // TRANSFERS
    case HomeRouterStatus.transfersView:
      return [BottomNavbarPage.page(), DynamicViewerPage.page()];
    case HomeRouterStatus.transfersReceipt:
      return [BottomNavbarPage.page(), DynamicViewerPage.page(),  ReceiptPage.page()];

    // RECIEPT
    case HomeRouterStatus.receipt:
      return [BottomNavbarPage.page(), ReceiptPage.page()];
    
    // SCANNER
    case HomeRouterStatus.scannerTransaction:
      return [BottomNavbarPage.page(), ScannerTransactionPage.page()];
    case HomeRouterStatus.scannerTransactionReceipt:
      return [BottomNavbarPage.page(), ScannerTransactionPage.page(), ReceiptPage.page()];
    
    // ADD ACCOUNT
    case HomeRouterStatus.addAccount:
      return [BottomNavbarPage.page(), AccountAddPage.page()];
    
    // NOTIFICATIONS
    case HomeRouterStatus.notifications:
      return [BottomNavbarPage.page(), NotificationPage.page()];
    case HomeRouterStatus.notificationViewer:
      return [BottomNavbarPage.page(), NotificationPage.page(), NotificationsViewerPage.page()];
    
    // SETTINGS
    case HomeRouterStatus.settings:
      return [BottomNavbarPage.page(), SettingsPage.page()];
    
    // UPDATE PASSWORD
    case HomeRouterStatus.updatePassword:
      return [BottomNavbarPage.page(), SettingsPage.page(), UpdatePasswordPage.page()];
    
    // REAUTHENTICATE
    case HomeRouterStatus.reauthenticate:
      return [BottomNavbarPage.page(), SettingsPage.page(), UpdatePasswordPage.page(), ReauthenticatePage.page()];
  }
}