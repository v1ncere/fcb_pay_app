import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/home_flow/home_flow.dart';
import 'package:fcb_pay_app/pages/receipt/receipt.dart';
import 'package:fcb_pay_app/pages/receipt/widgets/widgets.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({super.key});

  static final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () => context.flow<HomePageStatus>().update((state) => HomePageStatus.appBar)
          )
        ),
        body: BlocBuilder<ReceiptBloc, ReceiptState>(
          builder: (context, state) {
            if (state is ReceiptDisplayLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ReceiptDisplaySuccess) {
              return Column(
                children: [
                  RepaintBoundary(
                    key: _key,
                    child: CustomCard(receipts: state.receipts)
                  ),
                  ScreenshotButton(globalKey: _key)
                ]
              );
            }
            if (state is ReceiptDisplayError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.black38)
                )
              );
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