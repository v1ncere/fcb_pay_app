import 'package:flutter/material.dart';
import 'package:fcb_pay_app/ui/ui.dart';

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
        return MaterialPageRoute(builder: (_) => const BottomAppbar());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/add_account':
        return MaterialPageRoute(builder: (_) => const AddAccountPage());
      case '/delete_account':
        return MaterialPageRoute(builder: (_) => const DeleteAccountPage());
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