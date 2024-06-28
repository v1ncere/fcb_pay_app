import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app.dart';
import '../../../utils/enums.dart';
import '../../home_flow/home_flow.dart';
import '../receipt.dart';
import '../widgets/widgets.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({super.key});
  static final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InactivityDetector(
      onInactive: () => context.flow<HomeRouterStatus>().complete(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.x, size: 18),
              onPressed: () => context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.appBar)
            )
          ]
        ),
        body: BlocBuilder<ReceiptBloc, ReceiptState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status.isSuccess) {
              return RepaintBoundary(
                key: _key,
                child: Column(
                  children: [
                    CustomCard(receipts: state.receiptMap),
                  ]
                )
              );
            }
            if (state.status.isError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.black38)
                )
              );
            }
            else {
              return const SizedBox.shrink();
            }
          }
        ),
        bottomNavigationBar: ScreenshotButton(globalKey: _key)
      ),
    );
  }
}