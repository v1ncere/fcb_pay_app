import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../home/home.dart';
import '../dynamic_viewer.dart';

class SourceDropdown extends StatelessWidget {
  const SourceDropdown({
    super.key,
    required this.widget,
    required this.focusNode,
  });
  final PageWidget widget;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsHomeBloc, AccountsHomeState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.status.isSuccess) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField<String>(
                focusNode: focusNode,
                isExpanded: true,
                isDense: false,
                icon: const Icon(
                  FontAwesomeIcons.caretDown, 
                  color: Colors.green,
                  size: 16
                ),
                dropdownColor: Colors.white,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
                borderRadius: BorderRadius.circular(10.0),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorString.algaeGreen,
                  border: SelectedInputBorderWithShadow(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  )
                ),
                hint: Text(widget.title),
                onChanged: (value) {
                  context.read<WidgetsBloc>().add(
                    DynamicWidgetsValueChanged(
                      keyId: widget.keyId!,
                      title: widget.title,
                      value: value!,
                      type: widget.dataType,
                    )
                  );
                },
                selectedItemBuilder: (context) {
                  return state.accountList.map((item) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(accountTypeString(item.type)),
                        Text('${item.accountKeyID}'),
                        Text('${Currency.php}${(item.balance)!.toStringAsFixed(2).replaceAllMapped(Currency.reg, Currency.mathFunc)}'),
                      ]
                    );
                  }).toList();
                },
                items: state.accountList.map((item) {
                  return DropdownMenuItem<String> (
                    value: item.accountKeyID.toString(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(accountTypeString(item.type)),
                        Text('${item.accountKeyID}'),
                        Text('${Currency.php}${(item.balance)!.toStringAsFixed(2).replaceAllMapped(Currency.reg, Currency.mathFunc)}'),
                        const Divider()
                      ]
                    )
                  );
                }).toList()
              )
            )
          );
        }
        if (state.status.isError) {
          return Center(
            child: Text(state.message,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w900,
                fontSize: 16.0
              )
            )
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}

