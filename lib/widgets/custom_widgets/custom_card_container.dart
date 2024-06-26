import 'package:flutter/material.dart';

class CustomCardContainer extends StatelessWidget {
  const CustomCardContainer({
    super.key,
    required this.children,
    required this.color
  });
  final List<Widget> children;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color,
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // This will make the column take minimum space required by its children.
           crossAxisAlignment: CrossAxisAlignment.start,
          children: children
        )
      )
    );
  }
}