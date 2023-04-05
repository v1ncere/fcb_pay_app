import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/home_button_pages/home_button_pages.dart';
import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/pages/pin/pin.dart';
import 'package:fcb_pay_app/pages/register/register.dart';
import 'package:fcb_pay_app/pages/splash/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Splash());
      case '/create_pin':
        return MaterialPageRoute(builder: (_) => const CreatePin());
      case '/auth_pin':
        return MaterialPageRoute(builder: (_) => const AuthPinPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const BottomAppbarPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/add_account':
        return MaterialPageRoute(builder: (_) => const AddAccountPage());
      case '/transfer_to_pitakard':
        return MaterialPageRoute(builder: (_) => const AddAccountPage());
      case '/history':
        return MaterialPageRoute(builder: (_) => const AddAccountPage());
      case '/qr_pay':
        return MaterialPageRoute(builder: (_) => const AddAccountPage());
      case '/bills_payment':
        return MaterialPageRoute(builder: (_) => const AddAccountPage());
      case '/fund_transfer':
        return MaterialPageRoute(builder: (_) => const AddAccountPage());
      case '/pesonet':
        return MaterialPageRoute(builder: (_) => const AddAccountPage());
      default:
        return _error();
    }
  }

  static Route<dynamic> _error() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}