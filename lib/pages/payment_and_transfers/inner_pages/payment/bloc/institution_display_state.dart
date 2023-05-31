part of 'institution_display_bloc.dart';

enum InstitutionDisplayStatus { initial, progress, success, failure }

class InstitutionDisplayState extends Equatable {
  const InstitutionDisplayState({
    this.status = InstitutionDisplayStatus.initial,
    this.institution = const<Institution>[],
    this.error = '',
  });
  final InstitutionDisplayStatus status;
  final List<Institution> institution;
  final String error;

  InstitutionDisplayState copyWith({
    InstitutionDisplayStatus? status,
    List<Institution>? institution,
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

extension InstitutionDisplayStatusX on InstitutionDisplayStatus {
  bool get onInitial => this == InstitutionDisplayStatus.initial;
  bool get onProgress =>  this == InstitutionDisplayStatus.progress;
  bool get onSuccess => this == InstitutionDisplayStatus.success;
  bool get onFailure => this == InstitutionDisplayStatus.failure;
} 