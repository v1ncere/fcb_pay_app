import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';

class CarouselPRCard extends StatelessWidget {
  const CarouselPRCard({
    super.key,
    required this.data,
    required this.ownerId,
    required this.keyId
  });
  final String data;
  final String ownerId;
  final String keyId;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color:const Color(0xFF25C166),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: () {
          context.read<AppBloc>().add(AccountArgumentPassed(keyId)); // bloc events for passing args
          context.flow<AppStatus>().update((state) => AppStatus.account);
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Container()
            )
          )
        )
      )
    );
  }
}