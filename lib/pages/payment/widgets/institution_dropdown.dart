import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class InstitutionDropdown extends StatelessWidget {
  const InstitutionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionDisplayBloc, InstitutionDisplayState>(
      builder: (context, state) {
        if(state.status.isLoading) {
          return const Center(child: ShimmerRectLoading());
        }
        if(state.status.isSuccess) {
          return BlocBuilder<PaymentBloc, PaymentState>(
            buildWhen: (previous, current) => previous.formzStatus != current.formzStatus || current.isValid,
            builder: (paymentContext, paymentState) {
              return CustomDropdownButton(
                value: paymentState.institutionDropdown.value,
                hint: const Text("Select institution"),
                validator: (_) => paymentState.institutionDropdown.displayError?.text(),
                onChanged: (value) => context.read<PaymentBloc>().add(InstitutionValueChanged(value!)),
                items: state.institution.map((item) {
                  return DropdownMenuItem<String>(
                    value: item.name,
                    child: Text(item.name),
                    onTap: () => context.read<PaymentBloc>().add(UserWidgetFetched(item.keyId!))
                  );
                }).toList(),
              );
            }
          );
        }
        if(state.status.isError) {
          return Center(child: Text(state.error));
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }

  // void _onTextFieldInstantiate(BuildContext context, Institution item) {
  //   context.read<PaymentBloc>().add(ControllerValueRemoved());

  //   if (item.additionalWidget.isNotEmpty) {
  //     List<String> name = item.additionalWidget.trim().split(",");

  //     for (int i = 0; i < name.length; i++ ) {
  //       final controller = TextEditingController();
  //       final field = TextField(
  //         controller: controller,
  //         style: const TextStyle(
  //           color: Colors.black45,
  //           fontWeight: FontWeight.w700
  //         ),
  //         decoration: InputDecoration(
  //           filled: true,
  //           fillColor: Colors.black12,
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //             borderSide: BorderSide.none
  //           ),
  //           labelText: name[i],
  //         )
  //       );
  //       context.read<PaymentBloc>().add(ControllerValueChanged(controller, field, name));
  //     }
  //   }
  // }
}