import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

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
          final pos1 = int.parse(state.notifyFlag.substring(0, 1));
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.all(0),
            clipBehavior: Clip.antiAlias,
            color:const Color(0xFF25C166),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/bg.png"),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
                  fit: BoxFit.cover
                )
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.qrDataList.map((data) {
                    // condition
                    if (data.id == 'subs2803') {
                      return Column(
                        children: [
                          CustomRowText(
                            title: data.title,
                            titleColor: Colors.white,
                            titleFontSize: 12,
                            contentColor: Colors.white,
                            content: data.data,
                            contentFontWeight: FontWeight.w900,
                            contentFontSize: 12,
                          ),
                          const SizedBox(height: 15)
                        ]
                      );
                    }
                    if (data.id == 'subs2804' && pos1 == 3) {
                      return Column(
                        children: [
                          CustomRowText(
                            title: data.title,
                            titleColor: Colors.white,
                            titleFontSize: 12,
                            contentColor: Colors.white,
                            content: data.data,
                            contentFontWeight: FontWeight.w900,
                            contentFontSize: 12,
                          ),
                          const SizedBox(height: 15)
                        ]
                      );
                    }
                    if (data.id == 'main59') {
                      return Column(
                        children: [
                          CustomRowText(
                            title: data.title,
                            titleColor: Colors.white,
                            titleFontSize: 12,
                            contentColor: Colors.white,
                            content: data.data,
                            contentFontWeight: FontWeight.w900,
                            contentFontSize: 12,
                          ),
                          const SizedBox(height: 15)
                        ]
                      );
                    }
                    if (data.id == 'subs6205') {
                      return Column(
                        children: [
                          CustomRowText(
                            title: data.title,
                            titleColor: Colors.white,
                            titleFontSize: 12,
                            contentColor: Colors.white,
                            content: data.data,
                            contentFontWeight: FontWeight.w900,
                            contentFontSize: 12,
                          )
                        ]
                      );
                    }
                    if (data.widget == 'textfield') {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: CustomTextFormField(
                          title: data.title,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            context.read<ScannerTransactionBloc>().add(
                              ScannerExtraWidgetValueChanged(
                                id: data.id,
                                title: data.title,
                                data: data.data,
                                widget: data.widget
                              )
                            );
                          } 
                        )
                      );
                    }
                    else {
                      return const SizedBox.shrink();
                    }
                    // end condition
                  }).toList()
                )
              )
            )
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