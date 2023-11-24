import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:fcb_pay_app/pages/home_flow/home_flow.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // shadow color
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
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: const EdgeInsets.all( 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children:[
                    const SizedBox(width: 10),
                    Text(
                      'FCBPay', 
                      style:TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.black.withOpacity(0.2), // Shadow color
                            blurRadius: 3,
                            offset: const Offset(0, 1.5)
                          )
                        ]
                      )
                    )
                  ]
                ),
                Row(
                  children: [
                    IconButton(
                      splashRadius: 25,
                      icon: const Icon(
                        FontAwesomeIcons.solidBell,
                        size: 25,
                        color: Colors.white
                      ),
                      onPressed: () {
                        // pause the timer because it'll continue even after you navigate to other page
                        context.read<InactivityCubit>().pauseTimer();
                        context.flow<HomePageStatus>().update((state) => HomePageStatus.notifications);
                      }
                    ),
                    IconButton(
                      splashRadius: 25,
                      icon: const Icon(
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