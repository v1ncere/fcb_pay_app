import 'package:flutter/material.dart';

class AnimationDialog extends StatefulWidget {
  const AnimationDialog({super.key, required this.icon, required this.color});
  final IconData icon;
  final Color color;

  @override
  State<StatefulWidget> createState() => DialogState();
}

class DialogState extends State<AnimationDialog> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          side: BorderSide.none,
        ),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Icon(widget.icon, size: 30, color: widget.color),
          )
        )
      )
    );
  }
}