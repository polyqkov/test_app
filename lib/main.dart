import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/data/local/service/local_service.dart';
import 'package:test_app/internal/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
  );

  String apiKey = await LocalService().getApiKey() ?? '';

  runApp(App(isAuth: apiKey.isNotEmpty));
}
