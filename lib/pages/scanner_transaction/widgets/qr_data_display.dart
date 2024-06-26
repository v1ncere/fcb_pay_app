import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../scanner_transaction.dart';

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
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/bg.png'),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
                  fit: BoxFit.cover
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.qrDataList.map((data) {
                    if (data.id == 'subs2803' && pos1 == 3) { // Merchant ID
                      return displayText(data);
                    }
                    if (data.id == 'subs2804') { // Merchant Credit Account
                      return displayText(data);
                    }
                    if (data.id == 'main59') { // Merchant Name
                      return displayText(data);
                    }
                    if (data.id == 'subs6201') { // Bill Number
                      return displayText(data);
                    }
                    if (data.id == 'subs6203') { // Store Label
                      return displayText(data);
                    }
                    if (data.id == 'subs6204') { // Loyalty Number
                      return displayText(data);
                    }
                    if (data.id == 'subs6205') { // Reference label
                      return displayText(data);
                    }
                    if (data.id == 'subs6208') { // Purpose of transaction
                      return displayText(data);
                    }
                    if (data.id == 'main55') { // Tip or Convenience Indicator
                      return main55Widget(context, state, data);
                    }
                    if (data.id == 'subs6209') { // Additional Consumer Data Request
                      return additionalDataRequest(context, state, data);
                    }
                    if (data.widget == 'textfield') { // e.g Mobile Number,
                      return textFields(context, data);
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
  // widgets
  // display row text
  Widget displayText(QRModel data) {
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
  // textfield
  Widget textFields(BuildContext context, QRModel data) {
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
  // tip or convenience indicator
  Widget main55Widget(BuildContext context, ScannerTransactionState state, QRModel qr) {
    if(qr.data == '01') {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: CustomTextFormField(
          title: 'Convenience Fee',
          keyboardType: TextInputType.number,
          onChanged: (value) {
            context.read<ScannerTransactionBloc>().add(ScannerTipValueChanged(value));
          } 
        )
      );
    }
    if (qr.data == '02') {
      return Column(
        children: [
          CustomRowText(
            title: 'Convenience Fee',
            titleColor: Colors.white,
            titleFontSize: 12,
            contentColor: Colors.white,
            content: state.tip,
            contentFontWeight: FontWeight.w900,
            contentFontSize: 12,
          )
        ]
      );
    }
    if (qr.data == '03') {
      return Column(
        children: [
          CustomRowText(
            title: 'Convenience Fee %',
            titleColor: Colors.white,
            titleFontSize: 12,
            contentColor: Colors.white,
            content: state.tip,
            contentFontWeight: FontWeight.w900,
            contentFontSize: 12,
          )
        ]
      );
    }
    else {
      return const SizedBox.shrink();
    }
  }
  // Additional Consumer Data Request
  Widget additionalDataRequest(BuildContext context, ScannerTransactionState state, QRModel qr) {
    if(qr.data.contains('A')) {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: CustomTextFormField(
          title: 'Address',
          keyboardType: TextInputType.streetAddress,
          onChanged: (value) {
            context.read<ScannerTransactionBloc>().add(
              ScannerExtraWidgetValueChanged(
                id: '${qr.id}A', // subs6209A
                title: 'Address',
                data: value,
                widget: 'textfield'
              )
            );
          } 
        )
      );
    }
    if (qr.data.contains('M')) {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: CustomTextFormField(
          title: 'Mobile Number',
          keyboardType: TextInputType.streetAddress,
          onChanged: (value) {
            context.read<ScannerTransactionBloc>().add(
              ScannerExtraWidgetValueChanged(
                id: '${qr.id}M', // subs6209M
                title: 'Mobile Number',
                data: value,
                widget: 'textfield'
              )
            );
          } 
        )
      );
    }
    if (qr.data.contains('E')) {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: CustomTextFormField(
          title: 'Email Address',
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<ScannerTransactionBloc>().add(
              ScannerExtraWidgetValueChanged(
                id: '${qr.id}E', // subs6209E
                title: 'Email Address',
                data: value,
                widget: 'textfield'
              )
            );
          } 
        )
      );
    }
    else {
      return const SizedBox.shrink();
    }
  }
  // end
}