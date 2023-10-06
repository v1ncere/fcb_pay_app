import 'package:flutter/material.dart';

class CircleButtonWithLabel extends StatelessWidget {
  const CircleButtonWithLabel({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.function
  });
  final IconData icon;
  final String text;
  final Color color;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration:  BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2)
              )
            ]
          ),
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            child: Material(
              color: const Color(0xFF25C166),
              child: InkWell(
                splashColor: Colors.white60,
                onTap: function,
                child: Icon(icon, color: color)
              )
            )
          )
        ),
        const SizedBox(height: 2),
        FittedBox(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.black.withOpacity(0.15), // Shadow color
                  blurRadius: 1,
                  offset: const Offset(0, 1)
                )
              ]
            )
          )
        )
      ]
    );
  }
}