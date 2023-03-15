part of 'firebase_firestore_repository_bloc.dart';

abstract class FirebaseFirestoreRepositoryEvent extends Equatable {
  const FirebaseFirestoreRepositoryEvent();

  @override
  List<Object> get props => [];
}

class LoadAccounts extends FirebaseFirestoreRepositoryEvent {}

class UpdateAccounts extends FirebaseFirestoreRepositoryEvent {
  const UpdateAccounts(this.accounts);
  final List<Account> accounts;

  @override
  List<Object> get props => [accounts];
}

