part of 'bloc.dart';

enum RegStatus { none, loading, done, error }

extension RegStatusX on RegStatus {
  bool get isNone => this == RegStatus.none;
  bool get isDone => this == RegStatus.done;
  bool get isError => this == RegStatus.error;
  bool get isLoading => this == RegStatus.loading;
}

class RegState {
  const RegState({
    this.status = RegStatus.none,
    this.userModel,
    this.error,
  });

  final RegStatus status;
  final UserModel? userModel;
  final String? error;

  RegState copyWith({
    RegStatus? status,
    UserModel? userModel,
    String? error,
  }) {
    return RegState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      error: error ?? this.error,
    );
  }
}
