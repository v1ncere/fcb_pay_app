import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/login/login.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [BottomAppbarPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}