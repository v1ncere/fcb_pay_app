import 'package:fcb_pay_app/ui/login/login.dart';
import 'package:fcb_pay_app/ui/register/register.dart';
import 'package:fcb_pay_app/ui/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/ui/pin/pin_barrel.dart';
import 'package:fcb_pay_app/ui/splash/splash.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Splash());
      case '/create_pin':
        return MaterialPageRoute(builder: (_) => const CreatePin());
      case '/auth_pin':
        return MaterialPageRoute(builder: (_) => const AuthPin());
      case '/home':
        return MaterialPageRoute(builder: (_) => const BottomAppbar());
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());
      case '/login':
        return MaterialPageRoute(builder: (_) => const Login());
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