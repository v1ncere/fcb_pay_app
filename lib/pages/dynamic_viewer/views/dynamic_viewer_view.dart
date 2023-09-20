import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/pages/dynamic_viewer/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class DynamicViewerView extends StatelessWidget {
  const DynamicViewerView({super.key});
  static final _regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetsBloc, WidgetsState>(
      builder: (context, state) {
        if (state.widgetStatus.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.widgetStatus.isSuccess) {
          CustomCardContainer(
            color: const Color(0xFFFFFFFF),
            children: state.widgetList.map((widget) {
              switch(widget.widget) {
                case "textfield":
                  if(widget.dataType == "int") {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: CustomTextFormField(
                        title: widget.title ?? '',
                        inputFormatters: <ThousandsFormatter>[ThousandsFormatter(allowFraction: true)],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value?.isEmpty == true
                          ? 'Amount is required'
                          : _regex.hasMatch(value!)
                            ? null
                            : 'Amount is invalid. Please try again.';
                        },
                        onChanged: (value) {
                          context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
                            keyId: widget.keyId ?? "",
                            title: widget.title ?? "",
                            value: value,
                            type: widget.dataType ?? "",
                          ));
                        }
                      )
                    ); 
                  } else if(widget.dataType == "string") {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: CustomTextFormField(
                        title: widget.title ?? "",
                        validator: (value) {
                          return value?.isEmpty == true 
                          ? 'Oops! You forgot something. Please fill in this field.'
                          : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
                            keyId: widget.keyId ?? "",
                            title: widget.title ?? "",
                            value: value,
                            type: widget.dataType ?? "",
                          ));
                        }
                      )
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                case "dropdown":
                  return DynamicDropdown(
                    additional: widget.additional,
                    dataType: widget.dataType,
                    node: widget.node,
                    owner: widget.owner,
                    title: widget.title,
                    widget: widget.widget,
                  );
                case "text":
                  return const Text('data');
                default:
                  return const SizedBox.shrink();
              }
            }).toList()
          );
        }
        if (state.widgetStatus.isError) {
          return Center(
            child: Text('${state.errorMsg}'),
          );
        }
        else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

// gikan sa button pasa ug title sa node 