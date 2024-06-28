import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../app/app.dart';
import '../../home/home.dart';
import '../../home_flow/home_flow.dart';
import '../dynamic_viewer.dart';

class DynamicViewerPage extends StatelessWidget {
  const DynamicViewerPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: DynamicViewerPage());
  
  static final _firebaseRepository = FirebaseRealtimeDBRepository();
  static final _hiveRepository = HiveRepository();
  static final _firebaseAuth = FirebaseAuthRepository();
  
  @override
  Widget build(BuildContext context) {
    return BlocSelector<RouterBloc, RouterState, Button>(
      selector: (state) => state.button,
      builder: (context, button) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => _firebaseRepository), 
            RepositoryProvider(create: (context) => _hiveRepository)
          ],
          child: MultiBlocProvider(
            providers: [
              // inactivity cubit with event [resume timer] invoked
              BlocProvider(create: (context) => InactivityCubit()..resumeTimer()),
              // dropdown bloc 
              BlocProvider(create: (context) => DropdownBloc(firebaseRepository: _firebaseRepository)),
              // accounts home bloc with event [accounts home load] invoked
              BlocProvider(create: (context) => AccountsHomeBloc(
                firebaseRealtimeDBRepository: _firebaseRepository,
                hiveRepository: _hiveRepository,
              )..add(AccountsHomeLoaded())),
              // widgets bloc with event [widgets load] invoked
              BlocProvider(create: (context) => WidgetsBloc(
                firebaseAuth: _firebaseAuth,
                firebaseDatabase: _firebaseRepository,
                hiveRepository: _hiveRepository
              )..add(WidgetsLoaded(button.keyId ?? '')))
            ],
            child: DynamicViewerView(button: button)
          )
        );
      }
    );
  }
}