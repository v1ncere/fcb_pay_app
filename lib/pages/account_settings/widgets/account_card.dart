import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
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
    return SizedBox(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.all( 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Icon(icon, color: Colors.white, size: 18),
                ),
                Flexible(
                  child: FittedBox(
                    child: Text(text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w900,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  splashRadius: 25,
                  icon: const Icon(
                    FontAwesomeIcons.ellipsis,
                    size: 18,
                    color: Colors.white,
                  ),
                  onPressed: () { },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}