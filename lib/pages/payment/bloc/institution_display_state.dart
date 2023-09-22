part of 'institution_display_bloc.dart';

class InstitutionDisplayState extends Equatable {
  const InstitutionDisplayState({
    this.status = Status.initial,
    this.institution = const <Institutions>[],
    this.error = "",
  });
  final Status status;
  final List<Institutions> institution;
  final String error;

  InstitutionDisplayState copyWith({
    Status? status,
    List<Institutions>? institution,
    String? error,
  }) {
    return InstitutionDisplayState(
      status: status ?? this.status,
      institution: institution ?? this.institution,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [institution, status, error];
}