import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3)
          )
        ]
      ),
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: const Color(0xFF25C166),
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
                        fontWeight: FontWeight.w800,
                        fontSize: 18
                      )
                    )
                  ]
                ),
                Row(
                  children: [
                    IconButton(
                      splashRadius: 25,
                      icon: const FaIcon(
                        FontAwesomeIcons.solidBell,
                        size: 25,
                        color: Colors.white
                      ),
                      onPressed: () => context.flow<AppStatus>().update((state) => AppStatus.notifications)
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