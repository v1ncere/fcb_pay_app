import 'package:fcb_pay_app/ui/home/widgets/balance/balance.dart';
import 'package:fcb_pay_app/ui/home/widgets/header.dart';
import 'package:fcb_pay_app/ui/widgets/container_body.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeaderTitle(),
            ContainerBody(
              children: [
              Balance(),
              // Accounts(),
            ]
          )
        ],
      ),
    );
  }
}