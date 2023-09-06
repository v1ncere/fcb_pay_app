import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class AdditionalWidgets extends StatelessWidget {
  const AdditionalWidgets({super.key});

  static final _regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 3)
              )
            ),
          );
        } 
        if (state.status.isSuccess) {
          return Column(
            children: [
              state.widgetList.isNotEmpty ? const Divider(thickness: 2) : const SizedBox.shrink(), // line divider -----------------
              state.widgetList.isNotEmpty ? _description() : const SizedBox.shrink(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.widgetList.map((item) {
                  switch (item.widget) {
                    case 'textfield':
                      if(item.dataType == 'int') {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: CustomTextFormField(
                            title: item.title,
                            inputFormatters: <ThousandsFormatter>[ThousandsFormatter(allowFraction: true)],
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return value?.isEmpty == true
                              ? 'Amount is required'
                              : _regex.hasMatch(value!)
                                ? null
                                : 'Amount is invalid. Please try again.';
                            },
                            onChanged: (value) {
                              context.read<PaymentBloc>().add(AdditionalTextFieldValueChanged(
                                keyId: item.keyId!,
                                fieldTitle: item.title,
                                value: value,
                                type: item.dataType
                              ));
                            }
                          )
                        );
                      } else if(item.dataType == 'string') {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: CustomTextFormField(
                            title: item.title,
                            validator: (value) {
                              return value?.isEmpty == true 
                              ? 'Oops! You forgot something. Please fill in this field.'
                              : null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              context.read<PaymentBloc>().add(AdditionalTextFieldValueChanged(
                                keyId: item.keyId!,
                                fieldTitle: item.title,
                                value: value,
                                type: item.dataType
                              ));
                            }
                          )
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    case 'text':
                      return Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Text(item.content.toString(),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700
                          )
                        )
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                }).toList()
              )
            ]
          );
        } 
        if (state.status.isError) {
          return Text(
            state.message,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w700
            )
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }

  Widget _description() {
    return const Row(
      children: [
        Text("Additional Widgets",
          style: TextStyle(
            color: Color(0xFF25C166),
            fontWeight: FontWeight.w700
          )
        )
      ]
    );
  }
}