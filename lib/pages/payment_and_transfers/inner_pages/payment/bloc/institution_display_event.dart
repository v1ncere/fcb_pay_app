part of 'institution_display_bloc.dart';

abstract class InstitutionDisplayEvent extends Equatable {
  const InstitutionDisplayEvent();

  @override
  List<Object> get props => [];
}

class InstitutionDisplayLoaded extends InstitutionDisplayEvent {}

class InstitutionDisplayUpdated extends InstitutionDisplayEvent {
  const InstitutionDisplayUpdated(this.institution);
  final List<Institution> institution;

  @override
  List<Object> get props => [institution];
}
