part of 'inactivity_cubit.dart';

class InactivityState extends Equatable {
  const InactivityState({
    this.status = InactivityStatus.initial,
    this.isTimerPaused = false
  });
  final InactivityStatus status;
  final bool isTimerPaused;

  InactivityState copyWith({
    InactivityStatus? status,
    bool? isTimerPaused
  }) {
    return InactivityState(
      status: status ?? this.status,
      isTimerPaused: isTimerPaused ?? this.isTimerPaused
    );
  }
  
  @override
  List<Object> get props => [status, isTimerPaused];
}

enum InactivityStatus { initial, active, inactive }

extension InactivityStatusX on InactivityStatus {
  bool get isInitial => this == InactivityStatus.initial;
  bool get isActive => this == InactivityStatus.active;
  bool get isInactive => this == InactivityStatus.inactive;
}