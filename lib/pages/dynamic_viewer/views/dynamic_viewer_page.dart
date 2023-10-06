import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';

class DynamicViewerPage extends StatelessWidget {
  const DynamicViewerPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: DynamicViewerPage());
  static final _firebaseRepository = FirebaseRealtimeDBRepository();
  static final _hiveRepository = HiveRepository();
  
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, ButtonModel>(
      selector: (state) => state.buttonModel,
      builder: (context, buttonModel) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => _firebaseRepository),
            RepositoryProvider(create: (context) => _hiveRepository)
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => DropdownBloc(firebaseRepository: _firebaseRepository)),
              BlocProvider(create: (context) => WidgetsBloc(firebaseRepository: _firebaseRepository, hiveRepository: _hiveRepository)
              ..add(WidgetsLoaded(buttonModel.id))),
              BlocProvider(create: (context) => AccountsBloc(firebaseRepository: _firebaseRepository)
              ..add(AccountsLoaded()))
            ],
            child: DynamicViewerView(buttonModel: buttonModel)
          )
        );
      }
    );
  }
}