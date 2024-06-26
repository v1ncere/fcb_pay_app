import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../account.dart';
import 'widgets.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
      builder: (context, state) {
        return const Row(
          children: [
            Expanded(
              flex: 1, 
              child: SearchTextField()
            ),
            Flexible(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: PopUpMenuButton()
              )
            )
          ]
        );
      }
    );
  }
}