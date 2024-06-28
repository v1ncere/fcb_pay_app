import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    this.icon,
    this.buttonColor,
    this.titleColor,
    this.iconColor,
    this.onPressed,
  });
  final String title;
  final IconData? icon;
  final Color? buttonColor;
  final Color? titleColor;
  final Color? iconColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
        elevation: WidgetStateProperty.all(2),
        backgroundColor: WidgetStateProperty.all(buttonColor)
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title, 
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.w700
            )
          ),
          const SizedBox(width: 5),
          Icon(icon, color: iconColor, size: 20)
        ]
      )
    );
  }
}