import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/account/account.dart';
import 'package:fcb_pay_app/utils/utils.dart';

import 'search_button.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
      builder: (context, state) {
        return TextFormField(
          key: const Key('search_text_field'),
          decoration: InputDecoration(
            labelText: 'Search',
            filled: true,
            contentPadding: const EdgeInsets.only(left: 20.0, top: 15, right: 20, bottom: 15),
            fillColor: const Color.fromARGB(30, 37, 193, 102),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: SelectedInputBorderWithShadow(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none
            ),
            suffixIcon: const SearchButton()
          ),
          onChanged: (value) => context.read<TransactionHistoryBloc>().add(SearchTextFieldChanged(value))
        );
      }
    );
  }
}