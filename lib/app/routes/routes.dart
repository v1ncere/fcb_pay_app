import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/local_authentication/local_authentication.dart';
import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/pages/register/register.dart';

List<Page<dynamic>> onGeneratePages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.register:
      return [LoginPage.page(), RegisterPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    // local authentication
    case AppStatus.authenticated:
      return [AuthPinPage.page()];
    case AppStatus.createPin:
      return [AuthPinPage.page(), CreatePinPage.page()];
    case AppStatus.updatePin:
      return [AuthPinPage.page(), UpdatePinPage.page()];
    default:
      return [LoginPage.page()];
  }
}