import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';

class HomeDynamicPage extends StatelessWidget {
  const HomeDynamicPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomeDynamicPage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ButtonsBloc()),
        BlocProvider(create: (context) => SliderCubit()) // for the slider below the carousel
      ],
      child: const HomeDynamicView()
    );
  }
}