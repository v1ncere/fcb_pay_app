import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';

class PaymentSelectionView extends StatelessWidget {
  const PaymentSelectionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _TitleText(),
            const SizedBox(height: 10,),
            _PaymentInstitutionDropdown(),
            const SizedBox(height: 20,),
            _NextButton(),
            const SizedBox(height: 20,),
            _CancelButton()
          ]
        )
      ]
    );
  }
}

class _TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Select Institution:');
  }
}

class _PaymentInstitutionDropdown extends StatefulWidget {
  @override
  State<_PaymentInstitutionDropdown> createState() => _PaymentInstitutionDropdownState();
}

class _PaymentInstitutionDropdownState extends State<_PaymentInstitutionDropdown> {
  String? selectedVal;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentSelectionDropdownBloc, PaymentSelectionDropdownState>(
      builder: (context, state) {
        if(state.status.onProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if(state.status.onSuccess) {
          return Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.green),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String> (
                value: selectedVal,
                icon: const Icon(FontAwesomeIcons.caretDown),        
                iconSize: 24,
                elevation: 16,
                onChanged: (value) {
                  setState(() {
                    selectedVal = value;
                  });
                },
                items: state.institution.map((item) {
                  return DropdownMenuItem<String> (
                    value: item.name,
                    child: Text(item.name),
                  );
                }).toList(),
              ),
            ),
          );
        }
        if(state.status.onFailure) {
          return Center(child: Text("${state.error}"));
        }
        else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentStepperCubit, PaymentStepperState>(
      builder:(context, state) {
        return ElevatedButton(
          onPressed: () => context.read<PaymentStepperCubit>().stepContinued,
            child: const Text('Next'),
        );
      }
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentStepperCubit, PaymentStepperState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return TextButton(
          key: const Key('account_cancel_elevated_button'),
          onPressed: () => context.read<PaymentStepperCubit>().stepCancelled,
          child: const Text('CANCEL'),
        );
      },
    );
  }
}