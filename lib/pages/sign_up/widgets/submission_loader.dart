import 'package:flutter/material.dart';

class SubmissionLoader extends StatelessWidget {
  const SubmissionLoader({
    super.key,
    required this.progress
  });
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator.adaptive(
              backgroundColor: Colors.grey,
              value: progress
            ),
            const SizedBox(height: 5),
            Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(fontWeight: FontWeight.bold)
            ),
            const Text(
              'uploading data...',
              style: TextStyle(fontWeight: FontWeight.bold)
            )
          ]
        )
      )
    );
  }
}