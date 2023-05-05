import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/global_widgets/custom_widgets/container_body.dart';
import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';
import 'package:fcb_pay_app/pages/home_display/home_display.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                child: Text("Account Settings",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.rightFromBracket,
                  color: Colors.redAccent,
                ),
                onPressed: () { 
                  context.read<AppBloc>().add(const AppLogoutRequested());
                }
              ),
            ],
          ),
          ContainerBody(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 110,
                      child: AddAccountCard(
                        colors: Colors.green,
                        icon: FontAwesomeIcons.piggyBank,
                        text: "ADD ACCOUNT",
                        function: () {
                          Navigator.of(context).push<void>(AddAccountPage.route());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _AccountList(),
            ],
          ),
        ]
      ),
    );
  }
}

class _AccountList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDisplayBloc, HomeDisplayState> (
      builder: (context, state) {
        if(state is HomeDisplayLoadInProgress) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: CircularProgressIndicator()),
          );
        }
        if (state is HomeDisplayLoadSuccess) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 10.0,),
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemCount: state.homeDisplay.length,
            itemBuilder: (context, index) {
              return AccountCard(
                colors: Colors.white,
                function: () {},
                icon: FontAwesomeIcons.coins,
                text: state.homeDisplay[index].keyId!,
              );
            },

          );
        }
        if (state is HomeDisplayLoadError) {
          return Center(
            child: Text(state.error,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
              )
            )
          );
        }
        else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
