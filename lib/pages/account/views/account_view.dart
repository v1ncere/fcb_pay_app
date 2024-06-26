import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/color_string.dart';
import '../../bottom_navbar/bottom_navbar.dart';
import '../../home_flow/home_flow.dart';
import '../bloc/accounts_bloc.dart';
import '../widgets/widgets.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if(didPop) {
          context.read<InactivityCubit>().resumeTimer();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            account.category.toUpperCase(),
            style: TextStyle(
              color: ColorString.jewel,
              fontWeight: FontWeight.w700
            )
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<InactivityCubit>().resumeTimer();
                context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.appBar);
              },
              icon: const Icon(FontAwesomeIcons.x, size: 18)
            )
          ],
          automaticallyImplyLeading: false
        ),
        body: InactivityDetector(
          onInactive: () => context.flow<HomeRouterStatus>().complete(),
          child: RefreshIndicator(
            onRefresh: () async => context.read<AccountsBloc>().add(AccountsRefreshed(account)),
            child: ListView(
              children: const [
                CarouselSliderView(),
                SizedBox(height: 10),
                AccountDetailsView(),
                SizedBox(height: 10),
                ActionButtonView(),
                SizedBox(height: 20),
                TransactionHistoryView(),
                SizedBox(height: 20)
              ]
            )
          )
        )
      )
    );
  }
}