part of 'bottom_navigation_cubit.dart';

enum BottomNavTab { home, pay, scanner, settings, about }

class BottomNavigationState extends Equatable {
  const BottomNavigationState({this.tab = BottomNavTab.home});

  final BottomNavTab tab;

  @override
  List<Object> get props => [tab];
}
