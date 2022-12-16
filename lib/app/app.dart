import 'package:flutter/material.dart';

import 'package:fcb_pay_app/route/route_generator.dart';
import 'package:fcb_pay_app/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCBPay',
      debugShowCheckedModeBanner: false,
      theme: FlutterTheme(context: context).light,
      darkTheme: FlutterTheme(context: context).dark,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}