import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../account.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final account = context.select((CarouselCubit cubit) => cubit.state.account);
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
              accountID: account.accountKeyID!,
              searchQuery: state.searchQuery.value
            ));
          }
        );
      }
    );
  }
}