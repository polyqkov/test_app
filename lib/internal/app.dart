import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/internal/bloc/auth/bloc.dart';
import 'package:test_app/internal/bloc/login_in/bloc.dart';
import 'package:test_app/presentation/screens/auth_screen/auth_screen_view.dart';
import 'package:test_app/presentation/screens/done_screen/done_screen_view.dart';
import 'package:test_app/presentation/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.isAuth,
  });

  final bool isAuth;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: isAuth
            ? BlocProvider<LogInOutBloc>(
                create: (context) => LogInOutBloc(),
                child: const DoneScreenView(),
              )
            : BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(),
                child: const AuthScreenView(),
              ),
        theme: appTheme,
      );
}
