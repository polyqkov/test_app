import 'package:flutter/foundation.dart';

@immutable
class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => 'AuthException(message: $message)';
}
