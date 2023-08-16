import 'package:fcb_pay_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';

class QrDataDisplay extends StatelessWidget {
  const QrDataDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerTransactionBloc, ScannerTransactionState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status.isSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.qrDataList.map((data) {

              if (data.id == 'subs2803') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      )
                    ),
                    Text(
                      data.data, 
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                        fontSize: 14
                      )
                    ),
                    const SizedBox(height: 10)
                  ]
                );
              }
              if (data.id == 'main59') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      )
                    ),
                    Text(
                      data.data, 
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                        fontSize: 14
                      )
                    ),
                    const SizedBox(height: 10)
                  ]
                );
              }
              if (data.id == 'subs6205') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      )
                    ),
                    Text(
                      data.data, 
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                        fontSize: 14
                      )
                    ),
                    const SizedBox(height: 10)
                  ]
                );
              }
              if (data.widget == 'textfield') {
                return Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w700
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      labelText: data.title,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none
                      )
                    ),
                    onChanged: (value) {

                    }
                  ),
                );
              }
              else {
                return const SizedBox.shrink();
              }
  
            }).toList(),
          );
        }
        if (state.status.isError) {
          return Center(child: Text(state.message));
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}