part of 'bloc.dart';

enum LogInOutStatus { none, login, logout }

extension LogInOutStatusX on LogInOutStatus {
  bool get isNone => this == LogInOutStatus.none;
  bool get isLogIn => this == LogInOutStatus.login;
  bool get isLogOut => this == LogInOutStatus.logout;
}

class LogInOutState {
  const LogInOutState({
    this.status = LogInOutStatus.none,
  });

  final LogInOutStatus status;

  LogInOutState copyWith({
    LogInOutStatus? status,
  }) {
    return LogInOutState(status: status ?? this.status);
  }
}
