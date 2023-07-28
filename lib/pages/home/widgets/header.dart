import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: const Color.fromRGBO(0, 0, 0, 80),
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.all( 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children:[
                    SizedBox(width: 10),
                    Text(
                      'FCBPay', 
                      style:TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                      )
                    )
                  ]
                ),
                Row(
                  children: [
                    IconButton(
                      splashRadius: 25,
                      icon: const FaIcon(
                        FontAwesomeIcons.qrcode,
                        size: 22,
                        color: Colors.white,
                      ),
                      onPressed: () => context.flow<AppStatus>().update((state) => AppStatus.scanner)
                    ),
                    IconButton(
                      splashRadius: 25,
                      icon: const FaIcon(
                        FontAwesomeIcons.solidBell,
                        size: 25,
                        color: Colors.white
                      ),
                      onPressed: () {}
                    ),
                    IconButton(
                      splashRadius: 25,
                      icon: const FaIcon(
                        FontAwesomeIcons.circleQuestion,
                        size: 25,
                        color: Colors.white
                      ),
                      onPressed: () {}
                    )
                  ]
                )
              ]
            )
          )
        )
      )
    );
  }
}