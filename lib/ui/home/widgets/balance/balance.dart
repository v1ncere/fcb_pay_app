import 'package:fcb_pay_app/repository/model/account.dart';
import 'package:fcb_pay_app/ui/home/bloc/home_bloc.dart';
import 'package:fcb_pay_app/ui/home/widgets/balance/wallet_balance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);
  @override
  BalanceState createState() => BalanceState();
}

class BalanceState extends State<Balance> {
  
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(const GetData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {

        if (state is AccountLoaded) {
          List<AccountModel> data = state.accountData;

          return SizedBox(
            height: MediaQuery.of(context).size.height * .30,
            child: ListView.separated(
              itemCount: data.length,
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return WalletBalance(
                  account: data[index].account,
                  balance: data[index].balance,
                  walletBalance: data[index].walletBalance,
                );
              },
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_,__) => const SizedBox(width: 5.0),
            ),
          );

        } else if(state is AccountLoading) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return Container();
        }
      },
    );
  }
}