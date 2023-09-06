import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class CarouselSACardItem extends StatelessWidget {
  const CarouselSACardItem({
    super.key,
    required this.keyId,
    required this.balance,
    required this.type,
    required this.ownerId
  });
  final String keyId;
  final double balance;
  final String type;
  final String ownerId;

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("#,##0.00", "en_US");
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      color:const Color(0xFF25C166),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/bg.png"),
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
              fit: BoxFit.cover
            )
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRowText(
                  title: 'Balance',
                  titleColor: Colors.white,
                  contentColor: Colors.white,
                  content: f.format(balance),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: type.toUpperCase(),
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: keyId.replaceRange(0, keyId.length - 4, '***'),
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    )
                  ]
                )
              ]
            )
          )
        ),
        onTap: () {
          context.read<AppBloc>().add(AccountArgumentPassed(keyId)); // bloc events for passing args
          context.flow<AppStatus>().update((state) => AppStatus.account);
        }
      )
    );
  }
}