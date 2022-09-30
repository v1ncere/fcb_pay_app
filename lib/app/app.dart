import 'package:fcb_pay_app/route/route_generator.dart';
import 'package:fcb_pay_app/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCBPay',
      debugShowCheckedModeBanner: false,
      theme: FlutterTodosTheme(context: context).light,
      darkTheme: FlutterTodosTheme(context: context).dark,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}