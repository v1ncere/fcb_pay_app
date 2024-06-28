import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app.dart';
import '../../../utils/color_string.dart';
import '../../home_flow/home_flow.dart';
import '../bloc/accounts_bloc.dart';
import '../widgets/widgets.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return InactivityDetector(
      onInactive: () => context.flow<HomeRouterStatus>().complete(),
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
                context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.appBar);
              },
              icon: const Icon(FontAwesomeIcons.x, size: 18)
            )
          ],
          automaticallyImplyLeading: false
        ),
        body: RefreshIndicator(
          onRefresh: () async => context.read<AccountsBloc>().add(AccountsRefreshed(account)),
          child: ListView(
            children: [
              const CarouselSliderView(),
              const SizedBox(height: 10),
              const AccountDetailsView(),
              const SizedBox(height: 10),
              const ActionButtonView(),
              const SizedBox(height: 20),
              const TransactionHistoryView(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25)
            ]
          )
        )
      )
    );
  }
}