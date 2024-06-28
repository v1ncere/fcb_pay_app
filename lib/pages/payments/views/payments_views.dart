import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/utils.dart';
import '../../home/home.dart';
import '../payments.dart';
import '../widgets/widgets.dart';

class PaymentsViews extends StatelessWidget {
  const PaymentsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payments',
          style: TextStyle(
            color: ColorString.jewel,
            fontWeight: FontWeight.w700
          )
        )
      ),
      body: BlocBuilder<AccountsHomeBloc, AccountsHomeState>(
        builder: (context, state) {
          if(state.status.isLoading) {
            return Center(
              child: SpinKitThreeBounce(
                color: ColorString.eucalyptus,
                size: 20,
              )
            );
          }
          if(state.status.isSuccess) {
            return RefreshIndicator.adaptive(
              onRefresh: () async => context.read<PaymentButtonsBloc>().add(PaymentButtonsRefreshed()),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    PaymentButtonCardMenu()
                  ]
                )
              )
            );
          }
          if(state.status.isError) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    TextString.accountEmpty,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
              ),
            );
          }
          else {
            return const SizedBox.shrink();
          }
        }
      )
    );
  }
}