import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class Accounts extends StatelessWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('  Accounts',
          style: TextStyle(
            color: Color(0xFF30DD5B),
            fontWeight: FontWeight.bold)),
        AccountCard(),
      ]
    );
  }
}

class AccountCard extends StatelessWidget {
  const AccountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF30DD5B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 55,
        width: MediaQuery.of(context).size.width * .95,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("***7012", 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )
              ),
              IconButton(
                icon: const Icon(UniconsLine.sliders_v_alt, color: Color(0xFFFFFFFF),), 
                onPressed: () {  },
              )
            ]
          ),
        ),
      ),
    );
  }
}