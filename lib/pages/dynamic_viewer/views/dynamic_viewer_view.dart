import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/pages/dynamic_viewer/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class DynamicViewerView extends StatelessWidget {
  const DynamicViewerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dynamic Page"),
        ),
        body:  BlocBuilder<WidgetsBloc, WidgetsState>(
          builder: (context, state) {
            if (state.widgetStatus.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.widgetStatus.isSuccess) {
              return Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: SingleChildScrollView(
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
                          return SubmitButton(widget: widget);
                        default:
                          return const SizedBox.shrink();
                      }
                    }).toList()
                  )
                )
              );
            }
            if (state.widgetStatus.isError) {
              return Center(child: Text('${state.errorMsg}'));
            }
            else {
              return const SizedBox.shrink();
            }
          }
        )
      )
    );
  }
}