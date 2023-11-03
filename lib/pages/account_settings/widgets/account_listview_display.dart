import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/account_settings/widgets/widgets.dart';
import 'package:fcb_pay_app/pages/home/home.dart';

class AccountListViewDisplay extends StatelessWidget {
  const AccountListViewDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState> (
      builder: (context, state) {
        if(state is AccountsLoading) {
          return const ListViewShimmer();
        }
        if (state is AccountsSuccess) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 10.0,),
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemCount: state.accounts.length,
            itemBuilder: (context, index) {
              return AccountCard(
                colors: Colors.white,
                icon: FontAwesomeIcons.coins,
                account: state.accounts[index].keyId!
              );
            }
          );
        }
        if (state is AccountsError) {
          return Center(
            child: Text(state.message,
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