import 'package:fcb_pay_app/pages/account_settings/widgets/widgets.dart';
import 'package:flutter/material.dart';


class HeadersCard extends StatelessWidget {
  const HeadersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
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
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: const EdgeInsets.all( 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Row(
                  children:[
                    const SizedBox(width: 10),
                    Text(
                      'Account settings', 
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
                const LogoutButton(),
              ]
            )
          )
        )
      )
    );
  }
}