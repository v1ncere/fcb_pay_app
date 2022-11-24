import 'package:flutter/cupertino.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({
    super.key,
    required this.children
  });
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 10.0),
          children: children,
        ),
      ),
    );
  }
}