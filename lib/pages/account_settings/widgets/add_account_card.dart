import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddAccountCard extends StatelessWidget {
  const AddAccountCard({
    super.key,
    required this.icon,
    required this.text,
    required this.colors,
    required this.function
  });

  final IconData icon;
  final String text;
  final Color colors;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3)
          )
        ]
      ),
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: colors,
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            splashColor: Colors.black12,
            onTap: () =>  function(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 10,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(text, 
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w900,
                        fontSize: 8.0
                      )
                    )
                  ),
                  const SizedBox(width: 5),
                  Icon(icon, color: Colors.white, size: 16)
                ]
              )
            )
          )
        )
      )
    );
  }
}