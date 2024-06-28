import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../home_flow/home_flow.dart';
import '../dynamic_viewer.dart';
import '../widgets/widgets.dart';

class DynamicViewerView extends StatelessWidget {
  const DynamicViewerView({super.key, required this.button});
  final Button button;
  static final FocusNode focusNode = FocusNode(); // this is for open dropdown buttons

  @override
  Widget build(BuildContext context) {
    return BlocListener<WidgetsBloc, WidgetsState>(
      listener: (context, state) {
        if(state.submissionStatus.isSuccess) {
          context.flow<HomeRouterStatus>().update((next) => HomeRouterStatus.receipt);
          _showSuccessDialog(context, TextString.transactionSuccess);
        }
        if(state.submissionStatus.isError) {
          _showFailureSnackbar(context, state.message);
        }
      },
      child: InactivityDetector(
        onInactive: () {
          FocusScope.of(context).requestFocus(focusNode); // close the dropdown
          context.flow<HomeRouterStatus>().complete();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              button.title,
              style: const TextStyle(fontWeight: FontWeight.w700)
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  context.read<InactivityCubit>().resumeTimer();
                  context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.appBar);
                },
                icon: const Icon(FontAwesomeIcons.x, size: 18)
              )
            ]
          ),
          body: BlocBuilder<WidgetsBloc, WidgetsState>(
            builder: (context, state) {
              if (state.widgetStatus.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: colorStringParser(button.iconColor)
                  )
                );
              }
              if (state.widgetStatus.isSuccess) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                  child: state.dropdownHasData
                  ? CustomCardContainer(
                      color: const Color(0xFFFFFFFF),
                      children: state.widgetList.map((widget) {
                        switch(widget.widget) {
                          case 'dropdown':
                            return DropdownDisplay(focusNode: focusNode, pageWidget: widget);
                          case 'textfield':
                            return DynamicTextfield(widget: widget);
                          case 'text':
                            return DynamicText(widget: widget);
                          case 'multitextfield':
                            return MultiTextfield(widget: widget);
                          case 'button':
                            return SubmitButton(widget: widget, button: button);
                          default:
                            return const SizedBox.shrink();
                        }
                      }).toList()
                    )
                  : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        TextString.transactionDisabled,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                  )
                );
              }
              if (state.widgetStatus.isError) {
                return Center(child: Text(state.message));
              }
              else {
                return const SizedBox.shrink();
              }
            }
          )
        ),
      )
    );
  }

    // show success dialog 
  _showSuccessDialog(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.solidCircleCheck,
      backgroundColor: ColorString.eucalyptus,
      foregroundColor: ColorString.mystic
    ));
  }

  // show failure snackbar
  _showFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.triangleExclamation,
      backgroundColor: ColorString.guardsmanRed,
      foregroundColor: ColorString.mystic
    ));
  }
}