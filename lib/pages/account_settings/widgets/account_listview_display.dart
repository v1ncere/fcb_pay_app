import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../../home/home.dart';
import 'widgets.dart';

class AccountListViewDisplay extends StatelessWidget {
  const AccountListViewDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsHomeBloc, AccountsHomeState> (
      builder: (context, state) {
        if(state.status.isLoading) {
          return const ListViewShimmer();
        }
        if (state.status.isSuccess) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 10.0,),
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemCount: state.accountList.length,
            itemBuilder: (context, index) {
              return AccountCard(
                colors: Colors.white,
                icon: FontAwesomeIcons.coins,
                account: state.accountList[index].accountKeyID!
              );
            }
          );
        }
        if (state.status.isError) {
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