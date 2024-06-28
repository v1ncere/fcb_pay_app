part of 'carousel_cubit.dart';

class CarouselState extends Equatable {
  const CarouselState({
    this.index = 0,
    this.account = Account.empty
  });
  final int index;
  final Account account;

  CarouselState copyWith({
    int? index,
    Account? account
  }) {
    return CarouselState(
      index: index ?? this.index,
      account: account ?? this.account
    );
  }

  @override
  List<Object> get props => [index, account];
}