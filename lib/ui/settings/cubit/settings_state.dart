part of 'settings_cubit.dart';

enum SettingsStatus { loading, success, error }

class SettingsState extends Equatable {
  const SettingsState({this.status = SettingsStatus.loading});

  final SettingsStatus status;

  @override
  List<Object> get props => [];
}
