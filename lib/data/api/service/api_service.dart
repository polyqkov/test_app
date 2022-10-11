import 'package:hive/hive.dart';
import 'package:test_app/data/api/exceptions/auth_exception.dart';
import 'package:test_app/data/api/exceptions/reg_exception.dart';
import 'package:test_app/data/local/service/local_service.dart';
import 'package:test_app/domain/models/user_model.dart';
import 'package:uuid/uuid.dart';

class ApiService {
  final _uuid = const Uuid();
  final _duration = Future.delayed(const Duration(seconds: 2));

  Future<UserModel> auth({
    required String email,
    required String password,
  }) async {
    return _duration.then((v) async {
      final users = await Hive.openBox('users');

      if (users.containsKey(email)) {
        if (users.get(email) == password) {
          final apiKey = _uuid.v1();
          LocalService().addApiKey(apiKey: apiKey);

          return UserModel.fromJson({'email': email});
        } else {
          throw const AuthException('Неверный пароль');
        }
      } else {
        throw const AuthException('Такой аккаунт еще не существует');
      }
    });
  }

  Future<UserModel> reg({
    required String email,
    required String password,
  }) async {
    return _duration.then((v) async {
      final users = await Hive.openBox('users');

      if (!users.containsKey(email)) {
        users.put(email, password);
        final apiKey = _uuid.v1();
        LocalService().addApiKey(apiKey: apiKey);

        return UserModel.fromJson({'email': email});
      } else {
        throw const RegException('Такой аккаунт уже существует');
      }
    });
  }
}
