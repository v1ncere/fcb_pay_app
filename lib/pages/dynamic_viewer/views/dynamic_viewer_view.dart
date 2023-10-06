import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/pages/dynamic_viewer/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class DynamicViewerView extends StatelessWidget {
  const DynamicViewerView({super.key, required this.buttonModel});
  final ButtonModel buttonModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WidgetsBloc, WidgetsState>(
      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if(state.submissionStatus.isSuccess) {
          context.flow<AppStatus>().update((next) => AppStatus.dynamicReceipt);
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar("Transaction Successful!", FontAwesomeIcons.solidCircleCheck, Colors.white));
        }
        if(state.submissionStatus.isError) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(state.message!, FontAwesomeIcons.triangleExclamation, Colors.red));
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              buttonModel.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700
              )
            )
          ),
          body:  BlocBuilder<WidgetsBloc, WidgetsState>(
            builder: (context, state) {
              if (state.widgetStatus.isLoading) {
                return Center(child: CircularProgressIndicator(strokeWidth: 5, color: colorStringParser(buttonModel.iconColor)));
              }
              if (state.widgetStatus.isSuccess) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                  child: CustomCardContainer(
                    color: const Color(0xFFFFFFFF),
                    children: state.widgetList.map((widget) {
                      switch(widget.widget) {
                        case 'dropdown':
                          return DropdownSwitcher(widget: widget);
                        case 'textfield':
                          return DynamicTextfield(widget: widget);
                        case 'text':
                          return DynamicText(widget: widget);
                        case 'multitextfield':
                          return MultiTextfield(widget: widget);
                        case 'button':
                          return SubmitButton(widget: widget, buttonModel: buttonModel);
                        default:
                          return const SizedBox.shrink();
                      }
                    }).toList()
                  )
                );
              }
              if (state.widgetStatus.isError) {
                return Center(child: Text('${state.message}'));
              }
              else {
                return const SizedBox.shrink();
              }
            }
          )
        )
      )
    );
  }
}