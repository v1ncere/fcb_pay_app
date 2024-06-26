import 'package:flutter/material.dart';
// this button card is from deleted home
class ButtonCard extends StatelessWidget {
  const ButtonCard({
    super.key,
    required this.title,
    required this.titleColor,
    this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.function,
  });
  final String title;
  final Color titleColor;
  final IconData? icon;
  final Color iconColor;
  final Color bgColor;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3)
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            splashColor: Colors.black12,
            onTap: () => function(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(icon, color: iconColor),
                  Flexible(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                      )
                    )
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}