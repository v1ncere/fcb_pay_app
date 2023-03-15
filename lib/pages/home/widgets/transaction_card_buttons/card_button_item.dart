import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.iconData,
    required this.text,
    required this.colors,
    required this.function,
  });
  final IconData iconData;
  final String text;
  final Color colors;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(80, 80),
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
                  Icon(iconData, color: Colors.white,),
                  Flexible(
                    child: Text(text, 
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}