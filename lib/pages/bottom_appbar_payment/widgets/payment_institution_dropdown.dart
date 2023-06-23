import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_payment/bottom_appbar_payment.dart';

class PaymentInstitutionDropdown extends StatelessWidget {
  const PaymentInstitutionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionDisplayBloc, InstitutionDisplayState>(
      builder: (context, state) {
        if(state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if(state.status.isSuccess) {
          return BlocBuilder<PaymentBloc, PaymentState>(
            buildWhen: (previous, current) => previous.status != current.status || current.isValid,
            builder: (paymentContext, paymentState) {
              return Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.green),
                child: DropdownButtonFormField<String>(
                  value: paymentState.institutionDropdown.value,
                  icon: const Icon(FontAwesomeIcons.caretDown, color: Colors.green),        
                  iconSize: 18,
                  elevation: 16,
                  isExpanded: true,
                  validator: (_) => paymentState.institutionDropdown.displayError?.text(),
                  style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w700),
                  onChanged: (value) => context.read<PaymentBloc>().add(InstitutionValueChanged(value!)),
                  items: state.institution.map((item) {
                    return DropdownMenuItem<String> (
                      value: item.name,
                      child: Text(item.name),
                      onTap: () => _onTextFieldInstantiate(context, item)
                    );
                  }).toList(),
                ),
              );
            },
          );
        }
        if(state.status.isFailure) {
          return Center(child: Text(state.error));
        }
        else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void _onTextFieldInstantiate(BuildContext context, Institution item) {
    context.read<PaymentBloc>().add(ControllerValueRemoved());

    if (item.textField.isNotEmpty) {
      List<String> name = item.textField.trim().split(",");

      for (int i = 0; i < name.length; i++ ) {
        final controller = TextEditingController();
        final field = TextField(
          controller: controller,
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            labelText: name[i],
          ),
        );
        context.read<PaymentBloc>().add(ControllerValueChanged(controller, field, name));
      }
    }
  }
}