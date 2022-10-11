import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/internal/bloc/auth/bloc.dart';
import 'package:test_app/internal/bloc/login_in/bloc.dart';
import 'package:test_app/presentation/screens/auth_screen/auth_screen_view.dart';
import 'package:test_app/presentation/widgets/buttons/base_button.dart';

class DoneScreenView extends StatefulWidget {
  const DoneScreenView({Key? key}) : super(key: key);

  @override
  State<DoneScreenView> createState() => _DoneScreenViewState();
}

class _DoneScreenViewState extends State<DoneScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<LogInOutBloc>().add(LogInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://d1.skrinshoter.ru/s/250422/xnoyYOGB.png"),
            const SizedBox(height: 36),
            BaseButton(
              title: 'Выход',
              onTap: () {
                context.read<LogInOutBloc>().add(LogOutEvent());
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (BuildContext context) => BlocProvider<AuthBloc>(
                    create: (context) => AuthBloc(),
                    child: const AuthScreenView(),
                  ),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
