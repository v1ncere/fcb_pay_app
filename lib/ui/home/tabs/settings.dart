import 'package:flutter/cupertino.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}