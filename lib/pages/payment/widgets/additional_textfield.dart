import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';

class AdditionalTextField extends StatelessWidget {
  const AdditionalTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              state.widgetList.isNotEmpty ? _description() : const SizedBox.shrink(),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.widgetList.map((widget) {
                  switch (widget.widget) {
                    case "textfield":
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
                            labelText: widget.title,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none
                            )
                          ),
                          onChanged: (value) {
                            context.read<PaymentBloc>().add(
                              AdditionalTextFieldValueChanged(
                                keyId: widget.keyId!,
                                fieldTitle: widget.title,
                                value: value
                              )
                            );
                          }
                        ),
                      );
                    case "text":
                      return Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Text(widget.content.toString())
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                }).toList()
              )
            ]
          )
        );
      }
    );
  }

  Widget _description() {
    return const Row(
      children: [
        Text("additional form",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w700
          )
        )
      ]
    );
  }
}