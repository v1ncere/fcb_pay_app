import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/account/account.dart';
import 'package:fcb_pay_app/pages/account/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const ListTileShimmer();
        }
        if (state.status.isSuccess) {
          return ListView.separated(
            itemCount: state.transactions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final trans = state.transactions[index]; // specific [transaction] indexed
              return ListTile(
                key: ValueKey(trans),
                leading: Text(trans.accountType),
                title: Text(trans.accountNumber),
                subtitle: Text(trans.details),
                trailing: CustomText(
                  text: getDynamicDateString(state.transactions[index].timeStamp),
                  color: Colors.black45,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                horizontalTitleGap: 0, // gap between title and leading
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                thickness: 1.0,
                color: Color.fromARGB(50, 37, 193, 102),
              );
            },
          );
        }
        if (state.status.isError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w700
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