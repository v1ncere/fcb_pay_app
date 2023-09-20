import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:hive_repository/hive_repository.dart';

class DynamicViewerPage extends StatelessWidget {
  const DynamicViewerPage({super.key});
  static final _firebaseDatabase = FirebaseRealtimeDBRepository();
  static final _hiveRepository = HiveRepository();
  
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
                create: (context) => WidgetsBloc(
                  firebaseRepository: _firebaseDatabase,
                  hiveRepository: _hiveRepository
                )..add(WidgetsLoaded(args))
              )
            ],
            child: const DynamicViewerView()
          )
        );
      }
    );
  }
}