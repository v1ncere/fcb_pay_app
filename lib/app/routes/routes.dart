import 'package:flutter/material.dart';

import '../../pages/local_authentication/local_authentication.dart';
import '../../pages/login/login.dart';
import '../../pages/sign_up/sign_up.dart';
import '../../pages/sign_up_verify/sign_up_verify.dart';
import '../app.dart';

List<Page<dynamic>> onGeneratePages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.signupVerify:
      return [LoginPage.page(), SignUpVerifyPage.page()];
    case AppStatus.signup:
      return [LoginPage.page(), SignUpPage.page()];
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