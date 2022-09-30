import 'package:fcb_pay_app/ui/authentication_pin/page/authentication_pin.dart';
import 'package:fcb_pay_app/ui/create_pin/page/create_pin.dart';
import 'package:fcb_pay_app/ui/home/home.dart';
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
        return MaterialPageRoute(builder: (_) => const Home());
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