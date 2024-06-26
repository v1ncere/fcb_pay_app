import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../../bottom_navbar/bottom_navbar.dart';
import '../../home_flow/home_flow.dart';
import 'widgets.dart';

Card walletCard({
  required BuildContext context,
  required Account account
}) {
  return Card(
    elevation: 2.0,
    color: ColorString.eucalyptus,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(AssetString.splashLogo),
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
          fit: BoxFit.cover
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            ColorString.mountainMeadow,
            ColorString.zombie,
          ],
          stops: const [
            0.5,
            1.0
          ]
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'WALLET',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorString.white
                      )
                    ),
                  ],
                ),
                const Divider(color: Colors.white30)
              ]
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                context.read<RouterBloc>().add(RouterAccountsPassed(account));
                // pause the timer because it'll continue even after you navigate to other page
                context.read<InactivityCubit>().pauseTimer();
                context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.account);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildAccountNumber(value: account.accountKeyID!, type: account.type),
                      Icon(FontAwesomeIcons.chevronRight, size: 18, color: ColorString.white)
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildDetailsBlock(label: 'AVAILABLE BALANCE', value: Currency.fmt.format(account.balance))
                    ]
                  )
                ]
              )
            )
          ]
        )
      ),
    )
  );
}