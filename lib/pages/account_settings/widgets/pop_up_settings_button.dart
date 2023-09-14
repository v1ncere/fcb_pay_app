import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopUpSettingsButton extends StatelessWidget {
  const PopUpSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      clipBehavior: Clip.antiAlias,
      icon: const Icon(FontAwesomeIcons.ellipsis, color: Colors.white),
      iconSize: 18,
      onSelected: (value) {

      },  
      itemBuilder: (BuildContext context) {
        final settings = ['edit', 'remove'];
        return settings.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Text(value)
          );
        }).toList();
      }
    );
  }
}