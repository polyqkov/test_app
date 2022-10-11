part of 'bloc.dart';

abstract class AuthEvent {}

class AuthFetchEvent extends AuthEvent {
  AuthModel authModel;

  AuthFetchEvent({
    required this.authModel,
  });
}
