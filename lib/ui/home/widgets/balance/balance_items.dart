import 'package:flutter/material.dart';

class BalanceItems extends StatelessWidget {
  const BalanceItems({Key? key, required this.account, required this.balance, required this.walletBalance}) : super(key : key);
  final int account;
  final int balance;
  final int walletBalance;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color:const Color(0xFF02AE08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Wallet Balance", style: TextStyle(
                        color:Colors.white,
                        fontSize: 12),
                      ),
                      const SizedBox(height: 5),
                      Text("P${walletBalance.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22
                      )),
                  ]),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFFFFF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    icon: const Icon(Icons.wallet, color: Color(0xFF30DD5B),), 
                    label: const Text('Top up', style: TextStyle(color: Color(0xFF30DD5B))), 
                    onPressed: () { },
                  )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Pitakard Balance", style: TextStyle(
                        color: Colors.white,
                        fontSize: 12),
                      ),
                      const SizedBox(height: 5),
                      Text("P${balance.toStringAsFixed(2)}", style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22),
                      ),
                    ]
                  ),
              ]),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Account', style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 12)
                      ),
                      Text("$account".replaceRange(0, "$account".length - 4, "***"), style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)
                      ),
                  ]),
              ]),
          ]),
        ),
      ),
    );
  }
}