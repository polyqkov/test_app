import 'package:flutter/foundation.dart';

@immutable
class RegException implements Exception {
  final String message;

  const RegException(this.message);

  @override
  String toString() => 'RegException(message: $message)';
}
