import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocListener<PaymentBloc, PaymentState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.errorMsg ?? 'Oops! Something went wrong. Please try again.')));
            }
          },
          child: Column(
            children: [
              _MerchantDisplay(),
              const SizedBox(height: 50),
              _TransactionAmountInput(),
              const SizedBox(height: 20),
              _PaymentSubmitButton()
            ],
          ),
        )
    );
  }
}

class _MerchantDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayPaymentDataBloc, DisplayPaymentDataState>(
      builder: (context, state) {
        if (state.status.onProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status.onSuccess) {
          final date = DateTime.now();
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state.merchantId,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black38,
                      fontSize: 12
                    ),
                  ),
                  Text("${date.day}/${date.month}/${date.year}",
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.merchantName,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),
                  ),
                  Text(
                    "${date.hour}:${date.minute}",
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.referenceLabel,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),
                  )
                ]
              ),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    state.senderTransactionRef,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    state.traceNumber,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        if (state.status.onFailure) {
          return Center(child: Text(state.error));
        }
        else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _TransactionAmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc,PaymentState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return TextField(
          key: const Key('transaction_amount_input'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')), 
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          onChanged: (amount) => context.read<PaymentBloc>().add(PaymentTransactionAmountChanged(amount)),
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(FontAwesomeIcons.pesoSign),
            labelText: 'Amount',
            errorText: state.amount.displayError?.text(),
          ),
        );
      },
    );
  }
}

class _PaymentSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
          ? const CircularProgressIndicator()
          : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRect(
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF009405),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    splashColor: Colors.white38,
                    onTap: state.isValid
                      ? () => context.read<PaymentBloc>().add(PaymentSubmitted())
                      : null,
                    child: SizedBox(
                      height: 45,
                      width: 75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('PAY',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            FontAwesomeIcons.coins, 
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
      },
    );
  }
}