import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome 👋',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Vincent G. Gripo', 
              style: TextStyle(
                fontWeight: FontWeight.w400, 
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        const Text("FCB", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color:Color.fromARGB(255, 0, 151, 38),),)
      ],
    );
  }
}