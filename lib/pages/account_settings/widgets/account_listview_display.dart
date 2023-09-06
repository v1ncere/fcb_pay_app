import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/account_settings/widgets/widgets.dart';
import 'package:fcb_pay_app/pages/home/home.dart';

class AccountListViewDisplay extends StatelessWidget {
  const AccountListViewDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountDisplayBloc, AccountDisplayState> (
      builder: (context, state) {
        if(state is AccountDisplayInProgress) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(child: CircularProgressIndicator()));
        }
        if (state is AccountDisplaySuccess) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 10.0,),
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemCount: state.accounts.length,
            itemBuilder: (context, index) {
              return AccountCard(
                colors: Colors.white,
                function: () {},
                icon: FontAwesomeIcons.coins,
                text: state.accounts[index].keyId!
              );
            }
          );
        }
        if (state is AccountDisplayError) {
          return Center(
            child: Text(state.error,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w900,
                fontSize: 16.0
              )
            )
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}