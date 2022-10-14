import 'package:fcb_pay_app/repository/model/account.dart';
import 'package:fcb_pay_app/ui/home/bloc/home_bloc.dart';
import 'package:fcb_pay_app/ui/home/widgets/balance/balance_items.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);
  @override
  BalanceState createState() => BalanceState();
}

class BalanceState extends State<Balance> {
  int _currentIndex = 0;

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(const GetData());
    super.initState();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {

        if (state is AccountLoaded) {
          List<AccountModel> data = state.accountData;

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
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index; 
                    });
                  }
                ),
                items: data.map((e) {
                  return BalanceItems(
                   account: e.account,
                   balance: e.balance,
                   walletBalance: e.walletBalance,
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(data, (index, url) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index ? Colors.greenAccent : Colors.black12),
                  );
                })
              )
          ]);

        } else if(state is AccountLoading) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return Container();
        }
      },
    );
  }
}