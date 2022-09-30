import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class WalletBalance extends StatelessWidget {
  const WalletBalance({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 48, 221, 91),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                Text("Wallet Balance", style: TextStyle(
                  color: Colors.white,
                  fontSize: 16),),
                SizedBox(height: 5,),
                Text("P0.0", style: TextStyle(
                  color: Colors.white,
                  fontSize: 22),),
                ]
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                icon: const Icon(UniconsLine.plus, color: Color(0xFF30DD5B),), 
                label: const Text('Cash in', style: TextStyle(color: Color(0xFF30DD5B)),), 
                onPressed: () {  },
              )
            ]
          ),
        ),
      ),
    );
  }
}