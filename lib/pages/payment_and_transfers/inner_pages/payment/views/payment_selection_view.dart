import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/home_display/home_display.dart';
import 'package:fcb_pay_app/pages/payment_and_transfers/payment_and_transfers.dart';

class PaymentSelectionView extends StatelessWidget {
  const PaymentSelectionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TitleText(text: 'Select Institution',),
        _PaymentInstitutionDropdown(),
        const SizedBox(height: 15,),
        const _TitleText(text: 'Select Account',),
        _PaymentAccountDropdown(),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _NextButton(),
            const SizedBox(width: 10,),
            _CancelButton()
          ]
        )
      ]
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black38,
        fontWeight: FontWeight.w700
      ),
    );
  }
}

class _PaymentInstitutionDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionDisplayBloc, InstitutionDisplayState>(
      builder: (context, state) {
        if(state.status.onProgress) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if(state.status.onSuccess) {
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
                    );
                  }).toList(),
                ),
              );
            },
          );
        }
        if(state.status.onFailure) {
          return Center(child: Text(state.error));
        }
        else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _PaymentAccountDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDisplayBloc, HomeDisplayState>(
      builder: (context, state) {
        if(state is HomeDisplayLoadInProgress) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is HomeDisplayLoadSuccess) {
          return BlocBuilder<PaymentBloc, PaymentState>(
            buildWhen: (previous, current) => previous.status != current.status || current.isValid,
            builder: (paymentContext, paymentState) {
              return Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.green),
                child: DropdownButtonFormField<String> (
                  value: paymentState.accountDropdown.value,
                  icon: const Icon(FontAwesomeIcons.caretDown, color: Colors.green),        
                  iconSize: 18,
                  elevation: 16,
                  isExpanded: true,
                  validator: (_) => paymentState.accountDropdown.displayError?.text(),
                  style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w700, overflow: TextOverflow.ellipsis),
                  onChanged: (value) => context.read<PaymentBloc>().add(AccountValueChanged(value!)),
                  items: state.homeDisplay.map((item) {
                    return DropdownMenuItem<String> (
                      value: item.keyId.toString(),
                      child: Text("${item.keyId}"),
                    );
                  }).toList(),
                ),
              );
            },
          );
        }
        if (state is HomeDisplayLoadError) {
          return Center(
            child: Text(state.error,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
              )
            )
          );
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
    return ElevatedButton(
      onPressed: context.read<PaymentStepperCubit>().stepContinued,
      child: const Text('Next'),
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('account_cancel_elevated_button'),
      onPressed: context.read<PaymentStepperCubit>().stepCancelled,
      child: const Text('CANCEL'),
    );
  }
}