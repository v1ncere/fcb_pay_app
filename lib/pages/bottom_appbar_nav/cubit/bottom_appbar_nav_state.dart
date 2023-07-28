part of 'bottom_appbar_nav_cubit.dart';

enum BottomAppbarTab { home, transfer, accounts }

class BottomAppbarNavState extends Equatable {
  const BottomAppbarNavState({
    this.tab = BottomAppbarTab.home
  });
  final BottomAppbarTab tab;

  BottomAppbarNavState copyWith({
    BottomAppbarTab? tab,
  }) {
    return BottomAppbarNavState(
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object> get props => [tab];
}