import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.inputFormatters,
    this.keyboardType,
    this.autovalidateMode,
    required this.title,
    this.validator,
    this.onChanged
  });
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final String title;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.w700
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 211, 243, 224),
        labelText: title,
        labelStyle: const TextStyle(color: Colors.black54),
        border: SelectedInputBorderWithShadow(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none
        )
      ),
      autovalidateMode: autovalidateMode,
      validator: validator,
      onChanged: onChanged
    );
  }
}