import 'package:flutter/material.dart';

class CarouselPRCard extends StatelessWidget {
  const CarouselPRCard({
    super.key,
    required this.data,
    required this.ownerId,
    required this.keyId,
    required this.onTap
  });
  final String data;
  final String ownerId;
  final String keyId;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color:const Color(0xFF25C166),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: onTap,
        // onTap: () {
        //   context.read<AppBloc>().add(AccountArgumentPassed(keyId)); // bloc events for passing args
        //   context.flow<AppStatus>().update((state) => AppStatus.account);
        // },
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