import 'package:flutter/material.dart';

class StepperNextButton extends StatelessWidget {
  const StepperNextButton({
    super.key,
    required this.function
  });
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: MaterialStateProperty.all(Colors.green)
      ),
      onPressed: () => function != null ? function!() : null,
      child: const Text(
        "Next",
        style: TextStyle(
          fontWeight: FontWeight.w700
        )
      )
    );
  }
}