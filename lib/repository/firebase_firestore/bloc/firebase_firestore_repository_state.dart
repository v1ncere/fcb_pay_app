part of 'firebase_firestore_repository_bloc.dart';

abstract class FirebaseFirestoreRepositoryState extends Equatable {
  const FirebaseFirestoreRepositoryState();
  
  @override
  List<Object> get props => [];
}

class AccountLoading extends FirebaseFirestoreRepositoryState {}

class AccountLoad extends FirebaseFirestoreRepositoryState {
  const AccountLoad({this.account = const <Account>[]});
  final List<Account> account;

  @override
  List<Object> get props => [account];
}