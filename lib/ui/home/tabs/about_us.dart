import 'package:flutter/cupertino.dart';

class AboutUsTab extends StatelessWidget {
  const AboutUsTab({Key? key, required this.text}) : super(key: key);
  final String text;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}