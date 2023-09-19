import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/dynamic_viewer.dart/dynamic_viewer.dart';

class DynamicViewerPage extends StatelessWidget {
  const DynamicViewerPage({super.key});
  static final _firebaseDatabase = FirebaseRealtimeDBRepository();
  
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.args,
      builder: (context, args) {
        return RepositoryProvider(
          create: (context) => _firebaseDatabase,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => WidgetsBloc(firebaseRepository: _firebaseDatabase)
                ..add(WidgetsLoaded(args))
              )
            ],
            child: const DynamicViewerView(),
          )
        );
      }
    );
  }
}