part of 'bottom_appbar_cubit.dart';

enum BottomAppbarTab { home, transfer, accounts }

class BottomAppbarState extends Equatable {
  const BottomAppbarState({
    this.tab = BottomAppbarTab.home
  });
  final BottomAppbarTab tab;

  BottomAppbarState copyWith({
    BottomAppbarTab? tab,
  }) {
    return BottomAppbarState(
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object> get props => [tab];
}