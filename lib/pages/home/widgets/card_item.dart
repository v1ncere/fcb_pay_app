import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:fcb_pay_app/app/bloc/app_bloc.dart';
import 'package:fcb_pay_app/pages/home/widgets/widgets.dart';

class CardItem extends StatelessWidget {
  const CardItem({
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
    final staticAnchorKey = GlobalKey();
    return Card(
      clipBehavior: Clip.antiAlias,
      color:const Color(0xFF02AE08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
              child: Html(
                anchorKey: staticAnchorKey,
                data: data,
                style: style(),
                extensions: customExtentions(),
                onLinkTap: (url, _, __) {
                  debugPrint("Opening $url...");
                },
                onCssParseError: (css, messages) {
                  debugPrint("css that errored: $css");
                  debugPrint("error messages:");
                  for (var element in messages) {
                    debugPrint(element.toString());
                  }
                  return '';
                }
              )
            )
          )
        )
      )
    );
  }
}