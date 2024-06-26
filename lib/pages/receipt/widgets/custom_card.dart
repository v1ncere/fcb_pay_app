import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.receipts,
  });
  final Map<dynamic, dynamic> receipts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 15, left: 15, right: 15),
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 15, left: 15, right: 15),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: receipts.length,
                  itemBuilder: (context, index) {
                    var key = receipts.keys.elementAt(index);
                    if (key.toString() == 'time_stamp') {
                      return CustomRowText(
                        title: key.toString().replaceAll('_', ' '),
                        titleColor: Colors.black45,
                        content: getDateStringfromMillis(int.parse(receipts[key].toString())),
                        contentColor: Colors.green,
                      );
                    }
                    if (key.toString() == 'amount') {
                      return CustomRowText(
                        title: key.toString(),
                        titleColor: Colors.black45,
                        content: formatCurrency(double.parse(receipts[key].toString()), 'fil_PH'),
                        contentColor: Colors.green,
                      );
                    }
                    else {
                      return CustomRowText(
                        title: key.toString().replaceAll('_', ' '),
                        titleColor: Colors.black45,
                        content: receipts[key].toString(),
                        contentColor: Colors.green,
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  }
                )
              )
            )
          ),
          const FractionalTranslation(
            translation: Offset(0.0, -0.4),
            child: Align(
              alignment: FractionalOffset(0.5, 0.0),
              child: CircleAvatar(
                radius: 35.0,
                backgroundColor: Colors.teal,
                child: FittedBox(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'RECEIPT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        
                      )
                    )
                  )
                )
              )
            )
          )
        ]
      )
    );
  }
}

String formatCurrency(double amount, String locale) {
  return NumberFormat.simpleCurrency(locale: locale).format(amount);
}