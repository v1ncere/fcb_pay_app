import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          PasswordTextField(),
          SizedBox(height: 20),
          ConfirmPasswordTextField()
        ]
      )
    );
  }
}
