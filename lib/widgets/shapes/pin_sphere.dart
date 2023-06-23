import 'package:flutter/cupertino.dart';

class PinSphere extends StatelessWidget {
  const PinSphere({
    super.key,
    required this.input
  });
  final bool input;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 32.0, 15.0, 32.0),
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: input ? const Color(0xFF009966) : null,
          border:  Border.all(color: const Color(0xFF009966), width: 1),
          shape: BoxShape.circle
        ),
      ),
    );
  }
}