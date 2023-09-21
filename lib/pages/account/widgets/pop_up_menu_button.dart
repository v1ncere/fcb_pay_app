import 'package:fcb_pay_app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/account.dart';

class PopUpMenuButton extends StatelessWidget {
  const PopUpMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(left: 14, right: 14),
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 3)
            )
          );
        }
        if (state.status.isSuccess) {
          return BlocSelector<AppBloc, AppState, String>(
            selector: (state) => state.args,
            builder: (_, acc) {
              return PopupMenuButton(
                icon: Icon(
                  FontAwesomeIcons.filter,
                  color: Colors.green,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 1.5)
                    )
                  ]
                ),
                onSelected: (value) {
                  context.read<TransactionHistoryBloc>().add(TransactionHistoryLoaded(account: acc, filter: value));
                },
                itemBuilder: (BuildContext context) {
                  final filter = state.filters;
                  return filter.map((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(value)
                    );
                  }).toList();
                }
              );
            }
          );
        }
        if (state.status.isError) {
          return Center(child: Text(state.error));
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}