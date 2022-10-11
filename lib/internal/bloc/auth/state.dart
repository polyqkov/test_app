part of 'bloc.dart';

enum AuthStatus { none, loading, done, error }

extension AuthStatusX on AuthStatus {
  bool get isNone => this == AuthStatus.none;
  bool get isDone => this == AuthStatus.done;
  bool get isError => this == AuthStatus.error;
  bool get isLoading => this == AuthStatus.loading;
}

class AuthState {
  const AuthState({
    this.status = AuthStatus.none,
    this.userModel,
    this.error,
  });

  final AuthStatus status;
  final UserModel? userModel;
  final String? error;

  AuthState copyWith({
    AuthStatus? status,
    UserModel? userModel,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      error: error ?? this.error,
    );
  }
}
