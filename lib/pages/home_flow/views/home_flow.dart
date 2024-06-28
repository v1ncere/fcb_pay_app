import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_flow.dart';

class HomeFlow extends StatelessWidget {
  const HomeFlow._();
  static Route<HomeRouterStatus> route() => MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => RouterBloc(),
      child: const HomeFlow._()
    )
  );

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<HomeRouterStatus>(
      state: context.select((RouterBloc bloc) => bloc.state.status),
      onGeneratePages: onGenerateHomePages
    );
  }
}