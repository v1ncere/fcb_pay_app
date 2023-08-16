import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.amount,
    required this.confirm,
    required this.description,
    required this.reference,
    required this.timeStamp,
    required this.title
  });
  final double amount;
  final bool confirm;
  final String description;
  final int reference;
  final String title;
  final DateTime timeStamp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Stack(
        children: [
          Card(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text('${timeStamp.day}/${timeStamp.month}/${timeStamp.year}'),
                  const SizedBox(height: 10),
                  Text(title, style: const TextStyle(color: Colors.black)),
                  const SizedBox(height: 10),
                  Text(amount.toString(), style: const TextStyle(color: Colors.black)),
                  const SizedBox(height: 10),
                  Text(description, style: const TextStyle(color: Colors.black)),
                  const SizedBox(height: 10),
                  Text(reference.toString(), style: const TextStyle(color: Colors.black)),
                ]
              )
            )
          ),
          const FractionalTranslation(
            translation: Offset(0.0, -0.4),
            child: Align(
              alignment: FractionalOffset(0.5, 0.0),
              child: CircleAvatar(
                radius: 25.0,
                child: Text("A"),
              )
            )
          )
        ]
      )
    );
  }
}