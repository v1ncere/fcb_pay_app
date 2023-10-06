import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/account.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final acc = context.select((AppBloc bloc) => bloc.state.accountModel);
    return BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: const Color(0xFF25C166),
            shadows: <Shadow>[
              Shadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 3,
                offset: const Offset(0, 1.5)
              )
            ]
          ),
          onPressed: () {
            context.read<TransactionHistoryBloc>().add(TransactionHistoryLoaded(
              account: acc.account,
              searchQuery: state.searchQuery.value
            ));
          }
        );
      }
    );
  }
}