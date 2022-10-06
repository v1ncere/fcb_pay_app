part of 'bottom_appbar_cubit.dart';

enum BottomAppbarTab { home, pay, scanner, settings, about }

class BottomAppbarState extends Equatable {
  const BottomAppbarState({this.tab = BottomAppbarTab.home});

  final BottomAppbarTab tab;

  @override
  List<Object> get props => [tab];
}
