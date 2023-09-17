import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getIconData(String iconName) {
  switch (iconName) {
    case 'star':
      return FontAwesomeIcons.star;
    case 'heart':
      return FontAwesomeIcons.heart;
    
    default:
      return FontAwesomeIcons.circleQuestion; // Default icon
  }
}