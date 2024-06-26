import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../../bottom_navbar/bottom_navbar.dart';
import '../../home_flow/home_flow.dart';
import '../home.dart';
import '../widgets/widgets.dart';

class AccountHomeView extends StatelessWidget {
  const AccountHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsHomeBloc, AccountsHomeState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(FontAwesomeIcons.bars, color: Colors.black45)
            ),
            title: Text('Hello ${state.userDetails.firstName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorString.eucalyptus,
                fontSize: 18
              )
            ),
            actions: [
              IconButton(
                splashRadius: 25,
                icon: Icon(
                  FontAwesomeIcons.solidBell,
                  color: ColorString.eucalyptus
                ),
                onPressed: () {
                  // pause timer, to halt the navigation process
                  context.read<InactivityCubit>().pauseTimer();
                  context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.notifications);
                }
              ),
              IconButton(
                splashRadius: 25,
                icon: Icon(
                  FontAwesomeIcons.circleQuestion,
                  color: ColorString.eucalyptus
                ),
                onPressed: () {}
              )
            ]
          ),
          body: RefreshIndicator( 
            onRefresh: () async => context.read<AccountsHomeBloc>().add(AccountsHomeRefreshed()),
            child: const AccountsCardView()
          )
        );
      }
    );
  }
}