import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/scanner/scanner.dart';

class QrDataDisplay extends StatelessWidget {
  const QrDataDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerDisplayBloc, ScannerDisplayState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status.isSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.qrData.map((data) {
              if (data.widget == 'text' && data.data != '') {
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
                    const SizedBox(height: 10),
                  ]
                );
              }
              if (data.widget == 'text' && data.data == '') {
                return Row(
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                      )
                    )
                  ]
                );
              }
              else {
                return const SizedBox.shrink();
              }
            }).toList(),
          );
        }
        if (state.status.isFailure) {
          return Center(child: Text(state.error));
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}