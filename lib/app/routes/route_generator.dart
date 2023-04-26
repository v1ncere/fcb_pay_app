import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
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