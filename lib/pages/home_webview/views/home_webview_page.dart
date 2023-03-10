import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home_webview/bloc/home_webview_bloc.dart';
import 'package:fcb_pay_app/pages/home_webview/views/views.dart';
import 'package:fcb_pay_app/repository/repository.dart';

class HomeWebviewPage extends StatelessWidget {
  const HomeWebviewPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeWebviewBloc(firebaseDatabaseRepository: FirebaseDatabaseRepository())..add(HomeWebviewLoadRequested()),
      child: const HomeWebviewView(),
    );
  }
}