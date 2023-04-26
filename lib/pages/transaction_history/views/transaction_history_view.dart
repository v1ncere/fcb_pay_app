import 'package:fcb_pay_app/pages/transaction_history/bloc/transaction_history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionHistoryView extends StatelessWidget {
  const TransactionHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction History",
          style: TextStyle(
            color: Color(0xFF02AE08),
            fontWeight: FontWeight.w700
          ),
        ),
        centerTitle: true
      ),
      body: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
        builder: (context, state) {
          if (state is TransactionHistoryLoading) {
            return const Center(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is TransactionHistoryLoad) {
            return ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  key: ValueKey(state.transactions[index]),
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(state.transactions[index].transactionDetails)
                  ),
                );
              },
            );
          }
          if (state is TransactionHistoryError) {
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
      ),
    );
  }
}