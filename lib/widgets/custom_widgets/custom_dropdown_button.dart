import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/utils.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.value,
    required this.hint,
    required this.validator,
    required this.onChanged,
    required this.items,
    this.focusNode
  });
  final String? value;
  final Widget? hint;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<String>(
        focusNode: focusNode,
        isExpanded: true,
        value: value,
        icon: const Icon(FontAwesomeIcons.caretDown, color: Colors.green, size: 16),
        dropdownColor: Colors.white,
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w700, 
        ),
        borderRadius: BorderRadius.circular(10.0),
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorString.algaeGreen,
          border: SelectedInputBorderWithShadow(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none
          )
        ),
        hint: hint,
        validator: validator,
        onChanged: onChanged,
        items: items
      )
    );
  }
}