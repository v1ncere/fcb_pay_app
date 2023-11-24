import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home_flow/bloc/router_bloc.dart';
import 'package:fcb_pay_app/pages/home_flow/routes/routes.dart';

class HomeFlow extends StatelessWidget {
  const HomeFlow._();
  static Route<HomePageStatus> route() => MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => RouterBloc(),
      child: const HomeFlow._()
    )
  );

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<HomePageStatus>(
      state: context.select((RouterBloc bloc) => bloc.state.status),
      onGeneratePages: onGenerateHomePages
    );
  }
}