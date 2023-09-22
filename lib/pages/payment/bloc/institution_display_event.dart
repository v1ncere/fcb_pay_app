part of 'institution_display_bloc.dart';

abstract class InstitutionDisplayEvent extends Equatable {
  const InstitutionDisplayEvent();

  @override
  List<Object> get props => [];
}

class InstitutionDisplayLoaded extends InstitutionDisplayEvent {}

class InstitutionDisplayUpdated extends InstitutionDisplayEvent {
  const InstitutionDisplayUpdated(this.institutions);
  final List<Institutions> institutions;

  @override
  List<Object> get props => [institutions];
}
