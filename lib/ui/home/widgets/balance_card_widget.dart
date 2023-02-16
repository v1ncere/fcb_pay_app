import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:fcb_pay_app/repository/repository.dart';
import 'package:fcb_pay_app/ui/home/home.dart';


class Balance extends StatelessWidget {
  const Balance({super.key});
  
  @override
  Widget build(BuildContext context) {
    final current = context.select((HomeCubit cubit) => cubit.state.currentIndex);
    return BlocBuilder<AccountRepositoryBloc, AccountRepositoryState>(
      builder: (context, state) {
        if(state is AccountLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if(state is AccountLoaded) {
          return ValueListenableBuilder(
            valueListenable: Hive.box<Account>("ACCOUNT").listenable(),
            builder: (context, Box<Account> box, _) {
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
                    items: box.values.map((accounts) {
                      return BalanceItems(
                        account: accounts.account,
                        balance: accounts.balance,
                        walletBalance: accounts.walletBalance,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(box.values.toList(), (index, _) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: current == index ? Colors.greenAccent : Colors.black12,
                        ),
                      );
                    })
                  )
                ],
              );
            },
          );
          // Column(
          //   children: [
          //     CarouselSlider(
          //       options: CarouselOptions(
          //         height: 200.0,
          //         enlargeCenterPage: true,
          //         viewportFraction: 0.95,
          //         aspectRatio: 2.0,
          //         initialPage: 0,
          //         enableInfiniteScroll: false,
          //         onPageChanged: (index, _) {
          //           context.read<HomeCubit>().setCurrentIndex(index);
          //         }
          //       ),
          //       items: state.account.map((accounts) {
          //         return BalanceItems(
          //           account: accounts.account,
          //           balance: accounts.balance,
          //           walletBalance: accounts.walletBalance,
          //         );
          //       }).toList(),
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: map<Widget>(state.account, (index, _) {
          //         return Container(
          //           width: 10.0,
          //           height: 10.0,
          //           margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: current == index ? Colors.greenAccent : Colors.black12,
          //           ),
          //         );
          //       })
          //     )
          //   ],
          // );
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