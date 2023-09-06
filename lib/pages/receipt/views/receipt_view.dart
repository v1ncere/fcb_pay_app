import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/receipt/receipt.dart';
import 'package:fcb_pay_app/pages/receipt/widgets/widgets.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Receipt', style: TextStyle(color: Colors.green)),
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () => context.flow<AppStatus>().update((state) => AppStatus.authenticated),
          ),
        ),
        body: BlocBuilder<ReceiptBloc, ReceiptState>(
          builder: (context, state) {
            if (state is ReceiptDisplayLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ReceiptDisplaySuccess) {
              return CustomCard(
                amount: state.receipts.amount,
                confirm: state.receipts.confirm,
                description: state.receipts.description,
                reference: state.receipts.reference,
                title: state.receipts.title, 
                timeStamp: state.receipts.timeStamp,
              );
            }
            if (state is ReceiptDisplayError) {
              return Center(child: Text(state.error, style: const TextStyle(color: Colors.black38)));
            }
            else {
              return const SizedBox.shrink();
            }
          }
        )
      )
    );
  }
}