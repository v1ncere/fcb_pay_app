import 'package:fcb_pay_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.value,
    required this.hint,
    required this.validator,
    required this.onChanged,
    required this.items
  });
  final String? value;
  final Widget? hint;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.green),
      child: DropdownButtonFormField<String>(  
        value: value,
        icon: const Icon(FontAwesomeIcons.caretDown, color: Colors.green),
        iconSize: 16, 
        dropdownColor: Colors.white,
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(30, 37, 193, 102),
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