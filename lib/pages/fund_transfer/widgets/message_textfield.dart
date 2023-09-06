import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundTransferBloc, FundTransferState>(
      buildWhen: (previous, current) => previous.message != current.message,
      builder: (context, state) {
        return TextField(
          key: const Key('fund_message_input'),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLength: 100,
          minLines: 2,
          maxLines: 3,
          onChanged: (message) => context.read<FundTransferBloc>().add(MessageChanged(message)),
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w700
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(30, 37, 193, 102),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: 'Enter a message',
            labelStyle: const TextStyle(color: Colors.black26),
            errorText: state.message.displayError?.text()
          )
        );
      }
    );
  }
}