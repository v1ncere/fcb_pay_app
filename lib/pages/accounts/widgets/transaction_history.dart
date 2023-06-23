import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/accounts/accounts.dart';

class TransactionHistoryView extends StatelessWidget {
  const TransactionHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Transaction History',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w700
            ),
          ),
          const Divider(color: Colors.black),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SearchField(),
              const SizedBox(width: 10),
              _FilterButton(),
            ],
          ),
          const SizedBox(height: 10),
          BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
            builder: (context, state) {
              if (state is TransactionHistoryLoadInProgress) {
                return const Center(child: Center(child: CircularProgressIndicator()));
              }
              if (state is TransactionHistoryLoadSuccess) {
                return ListView.builder(
                  itemCount: state.transactions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      key: ValueKey(state.transactions[index]),
                      child: SizedBox(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(state.transactions[index].transactionDetails)
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is TransactionHistoryLoadError) {
                return Center(
                  child: Text(state.error,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                    )
                  )
                );
              }
              else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchInputsBloc, SearchInputsState>(
      builder: (context, state) {
        return SizedBox(
          width: 250,
          child: TextField(
            key: const Key('search_text_field'),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: 'Search',
            ),
            onChanged: (value) {
              context.read<SearchInputsBloc>().add(SearchTextFieldChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchInputsBloc, SearchInputsState>(
      builder: (context, state) {
        final data = context.select((AppBloc bloc) => bloc.state.args);
        return SizedBox(
          height: 55,
          child: ElevatedButton(
            child: const Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.white),
            onPressed: () {
              final event = TransactionHistoryLoaded(account: data, searchQuery: state.searchQuery.value);
              context.read<TransactionHistoryBloc>().add(event);
            },
          ),
        );
      },
    );
  }
}