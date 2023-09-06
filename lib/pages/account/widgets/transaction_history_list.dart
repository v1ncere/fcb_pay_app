import 'package:fcb_pay_app/pages/account/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/account.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchInputsBloc, SearchInputsState>(
      builder: (context, state) {
        final data = context.select((AppBloc bloc) => bloc.state.args);
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transaction History',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700
                )
              ),
              const Divider(color: Colors.black),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      key: const Key('search_text_field'),
                      decoration: InputDecoration(
                        labelText: 'Search',
                        filled: true,
                        contentPadding: const EdgeInsets.only(left: 20.0, top: 15, right: 20, bottom: 15),
                        fillColor: const Color.fromARGB(30, 37, 193, 102),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none
                        )
                      ),
                      onChanged: (value) => context.read<SearchInputsBloc>().add(SearchTextFieldChanged(value))
                    )
                  ),
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IconButton(
                        icon: const Icon(FontAwesomeIcons.magnifyingGlass, color: Color(0xFF25C166)),
                        onPressed: () {
                          context.read<TransactionHistoryBloc>().add(
                            TransactionHistoryLoaded(
                              account: data,
                              searchQuery: state.searchQuery.value
                            )
                          );
                        }
                      ),
                    )
                  )
                ]
              ),
              const SizedBox(height: 10),
              BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
                builder: (context, state) {
                  if (state is TransactionHistoryLoadInProgress) {
                    return const ListTileShimmer();
                  }
                  if (state is TransactionHistoryLoadSuccess) {
                    return ListView.separated(
                      itemCount: state.transactions.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          key: ValueKey(state.transactions[index]),
                          title: Text(state.transactions[index].accountNumber),
                          subtitle: Text(state.transactions[index].details),
                          trailing: CustomText(
                            text: getDynamicDateString(state.transactions[index].timeStamp),
                            color: Colors.black45,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1.0,
                          color: Color.fromARGB(50, 37, 193, 102),
                        );
                      },
                    );
                  }
                  if (state is TransactionHistoryLoadError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w700
                        )
                      )
                    );
                  }
                  else {
                    return const SizedBox.shrink();
                  }
                }
              )
            ]
          )
        );
      }
    );
  }
}