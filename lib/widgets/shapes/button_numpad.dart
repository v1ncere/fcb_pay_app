import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class ButtonNumPad extends StatelessWidget {
  const ButtonNumPad({
    super.key,
    required this.num,
    this.onPressed
  });

  final String num;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: FloatingActionButton.extended(
        heroTag: num,
        shape: const CircleBorder(),
        elevation: 0,
        backgroundColor: ColorString.eucalyptus,
        onPressed: onPressed,
        label: Text(
          num, 
          style: const TextStyle(
            color: Colors.white
          )
        )
      )
    );
  }
}

// ORIGINAL
// import 'package:flutter/material.dart';

// class ButtonNumPad extends StatelessWidget {
//   const ButtonNumPad({
//     super.key,
//     required this.num,
//     this.onPressed
//   });

//   final String num;
//   final VoidCallback? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return FittedBox(
//       child: FloatingActionButton.extended(
//         heroTag: num,
//         shape: const CircleBorder(),
//         elevation: 0,
//         backgroundColor: const Color(0xFFf5f5f8),
//         onPressed: onPressed,
//         label: Text(
//           num, 
//           style: const TextStyle(
//             color: Color(0xFF009966)
//           )
//         )
//       )
//     );
//   }
// }