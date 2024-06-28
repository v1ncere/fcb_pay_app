import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

import 'widgets.dart';

class ExtraDisplayDeposit extends StatelessWidget {
  const ExtraDisplayDeposit({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        mainInfoBlock(label: 'AVAILABLE BALANCE', value: Currency.fmt.format(account.balance)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Table(
            columnWidths: const <int, TableColumnWidth> {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2)
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              tableRow(label: 'ACCOUNT TYPE', value: account.type.toUpperCase()),
              tableRow(label: 'ACCOUNT NUMBER', value: account.accountKeyID!)
            ]
          )
        )
      ]
    );
  }
}

TableRow tableRow({
  required String label,
  required String value,
}) {
  return TableRow(
    children: [
      Text(
        label,
        style: TextStyle(
          color: ColorString.eucalyptus,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          shadows: <Shadow>[
            Shadow(
              color: Colors.black.withOpacity(0.15), // Shadow color
              blurRadius: 1,
              offset: const Offset(0, 1)
            )
          ]
        ),
      ),
      Text(
        value,
        style: TextStyle(
          color: ColorString.eucalyptus,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          shadows: <Shadow>[
            Shadow(
              color: Colors.black.withOpacity(0.15), // Shadow color
              blurRadius: 1,
              offset: const Offset(0, 1)
            )
          ]
        )
      )
    ]
  );
}