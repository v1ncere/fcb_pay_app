import 'package:fcb_pay_app/repository/account_repository/bloc/account_repo_bloc.dart';
import 'package:fcb_pay_app/ui/home/cubit/home_cubit.dart';
import 'package:fcb_pay_app/ui/home/widgets/balance/balance_items.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final current = context.select((HomeCubit cubit) => cubit.state.currentIndex);
    return BlocBuilder<AccountRepoBloc, AccountRepoState>(
      builder: (context, state) {
        if(state is AccountLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if(state is AccountLoaded) {
          return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                viewportFraction: 0.95,
                aspectRatio: 2.0,
                initialPage: 0,
                enableInfiniteScroll: false,
                onPageChanged: (index, _) {
                  context.read<HomeCubit>().setCurrentIndex(index);
                }
              ),
              items: state.accountModel.map((accounts) {
                return BalanceItems(
                    account: accounts.account,
                    balance: accounts.balance,
                    walletBalance: accounts.walletBalance,
                  );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(state.accountModel, (index, _) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: current == index ? Colors.greenAccent : Colors.black12),
                );
              })
            )
          ]);
        }
        else {
          return const Center(child: Text("Something went wrong."));
        }
      }
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}