import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class WalletBalance extends StatelessWidget {
  const WalletBalance({Key? key, 
    required this.account,
    required this.balance,
    required this.walletBalance}) : super(key : key);
  final int account;
  final int balance;
  final int walletBalance;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF30DD5B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * .95,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Wallet Balance", style: TextStyle(
                        color: Colors.white,
                        fontSize: 12),),
                      const SizedBox(height: 5,),
                      Text("P${walletBalance.toStringAsFixed(2)}", style: const TextStyle(
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
              const SizedBox(height: 8.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Pitakard Balance", style: TextStyle(
                      color: Colors.white,
                      fontSize: 12),),
                      const SizedBox(height: 5,),
                      Text("P${balance.toStringAsFixed(2)}", style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22),),
                    ]
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    icon: const Icon(UniconsLine.plus, color: Color(0xFF30DD5B),), 
                    label: const Text('Cash in', style: TextStyle(color: Color(0xFF30DD5B)),), 
                    onPressed: () {  },
                  )
                ]
              ),
              const SizedBox(height: 16.0,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Account', style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 12)
                      ),
                      Text("$account", style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}