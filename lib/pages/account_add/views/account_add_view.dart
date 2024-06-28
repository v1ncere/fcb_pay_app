import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../app/app.dart';
import '../../../utils/utils.dart';
import '../../home_flow/home_flow.dart';
import '../account_add.dart';
import '../widgets/widgets.dart';

class AccountAddView extends StatelessWidget {
  const AccountAddView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountAddBloc, AccountAddState>(
      builder: (context, state) {
        const shrink = SizedBox.shrink();
        return LoadingStack(
          isLoading: state.formStatus.isInProgress,
          child: InactivityDetector(
            onInactive: () => context.flow<HomeRouterStatus>().complete(),
            child: Scaffold(
              appBar:  AppBar(
                title: const Text(
                  'Add Account',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700
                  )
                ),
                actions: [
                  IconButton(
                    onPressed: () => context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.appBar),
                    icon: const Icon(FontAwesomeIcons.x, size: 18)
                  )
                ],
                automaticallyImplyLeading: false,
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    const AccountTypeDropdown(),
                    state.accountType.isUnknown ? shrink : const SizedBox(height: 20),
                    state.accountType.isUnknown ? shrink : const AccountNumberInput(),
                    state.accountType.isSavings ? const SizedBox(height: 20) : shrink,
                    state.accountType.isSavings ? const FullName() : shrink,
                    state.accountType.isUnknown ? shrink : const SizedBox(height: 20),
                    state.accountType.isUnknown ? shrink : const BirthDate()
                  ]
                )
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(), // line divider ---------------------
                    noteText(),
                    const SizedBox(height: 15.0),
                    const SizedBox(
                      width: double.infinity,
                      child: SubmitAccountButton()
                    )
                  ]
                )
              )
            ),
          )
        );  
      }
    );
  }
}
