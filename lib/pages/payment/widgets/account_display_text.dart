import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';

class AccountDisplayText extends StatelessWidget {
  const AccountDisplayText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.args,
      builder: (context, args) {
        return Text(
          args,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700
          ),
        );
      },
    );
  }
}