import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.icon,
    required this.text,
    required this.colors,
    required this.function,
  });
  final IconData icon;
  final String text;
  final Color colors;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(75, 75),
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: colors,
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            splashColor: Colors.black12,
            onTap: () =>  function(),
            child: Padding(
              padding: const EdgeInsets.all( 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FaIcon(icon, color: Colors.white),
                  Flexible(
                    child: Text(text, 
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0
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