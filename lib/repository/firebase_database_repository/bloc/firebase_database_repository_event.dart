part of 'firebase_database_repository_bloc.dart';

abstract class FirebaseDatabaseRepositoryEvent extends Equatable {
  const FirebaseDatabaseRepositoryEvent();
  
  @override
  List<Object> get props => [];
}

class GetDisplayEvent extends FirebaseDatabaseRepositoryEvent {}

class DisplayDeletedEvent extends FirebaseDatabaseRepositoryEvent {}



