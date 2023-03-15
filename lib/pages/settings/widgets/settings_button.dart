import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.iconData,
    required this.text,
    required this.colors,
    required this.methods,
  });
  final IconData iconData;
  final String text;
  final Color colors;
  final Function methods;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width,
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: colors, 
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            splashColor: Colors.black12,
            onTap: () => methods(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(iconData, color: Colors.white,),
                  const SizedBox(width: 15.0,),
                  Flexible(
                    child: Text(text, 
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w300,
                        fontSize: 20.0), 
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}