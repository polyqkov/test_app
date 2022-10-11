import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalService {
  static const _storage = FlutterSecureStorage();

  Future<void> addApiKey({
    required String apiKey,
  }) =>
      _storage.write(key: 'api_key', value: apiKey);

  Future<String?> getApiKey() => _storage.read(key: 'api_key');

  Future<void> deleteApiKey() => _storage.delete(key: 'api_key');
}
