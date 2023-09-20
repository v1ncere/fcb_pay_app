import 'package:fcb_pay_app/widgets/widgets.dart';
import 'package:flutter/widgets.dart';

class DynamicDropdown extends StatelessWidget {
  const DynamicDropdown({
    super.key,
    this.additional,
    this.dataType,
    this.node,
    this.owner,
    this.title,
    this.widget
  });
    final bool? additional;
    final String? dataType;
    final String? node;
    final String? owner;
    final String? title;
    final String? widget;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton(
      value:"",
      hint: const Text(""),
      onChanged: (value) {},
      validator: (value) {
        return null;
      },
      items: const [],
    );
  }
}