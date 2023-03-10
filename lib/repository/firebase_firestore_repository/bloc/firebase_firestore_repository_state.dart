part of 'firebase_firestore_repository_bloc.dart';

abstract class FirebaseFirestoreRepositoryState extends Equatable {
  const FirebaseFirestoreRepositoryState();
  
  @override
  List<Object> get props => [];
}

class AccountLoading extends FirebaseFirestoreRepositoryState {}

class AccountLoaded extends FirebaseFirestoreRepositoryState {
  const AccountLoaded({this.account = const <Account>[]});
  final List<Account> account;

  @override
  List<Object> get props => [account];
}