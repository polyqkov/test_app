import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/data/api/models/auth_model.dart';
import 'package:test_app/internal/bloc/auth/bloc.dart';
import 'package:test_app/internal/bloc/login_in/bloc.dart';
import 'package:test_app/presentation/screens/done_screen/done_screen_view.dart';
import 'package:test_app/presentation/screens/fail_screen/fail_screen_view.dart';
import 'package:test_app/presentation/screens/reg_email_screeen/reg_email_screen_view.dart';
import 'package:test_app/presentation/theme/app_text_styles.dart';
import 'package:test_app/presentation/widgets/buttons/base_button.dart';
import 'package:test_app/presentation/widgets/buttons/base_text_button.dart';
import 'package:test_app/presentation/widgets/textfields/email_text_field.dart';
import 'package:test_app/presentation/widgets/textfields/password_text_field.dart';

class AuthScreenView extends StatefulWidget {
  const AuthScreenView({Key? key}) : super(key: key);

  @override
  State<AuthScreenView> createState() => _AuthScreenViewState();
}

class _AuthScreenViewState extends State<AuthScreenView> {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  bool _isEmailError = false;
  bool _isPasswordError = false;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: ListView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: MediaQuery.of(context).padding.bottom,
                left: 18,
                right: 18,
              ),
              children: [
                const SizedBox(height: 54),
                const Text(
                  'Авторизация',
                  style: AppTextStyle.title1Bold,
                ),
                const SizedBox(height: 36),
                EmailTextField(
                  controller: _emailEditingController,
                  isError: _isEmailError,
                  onChanged: (value) => value.isEmpty
                      ? setState(() => _isEmailError = false)
                      : setState(() => _isEmailError =
                          !EmailValidator.validate(value, true)),
                ),
                const SizedBox(height: 18),
                PasswordTextField(
                  controller: _passwordEditingController,
                  isError: _isPasswordError,
                  onChanged: (value) => value.isEmpty
                      ? setState(() => _isPasswordError = true)
                      : setState(() => _isPasswordError = false),
                ),
                const SizedBox(height: 36),
                BaseButton(
                  title: 'Войти',
                  isLoading: authState.status.isLoading,
                  onTap: authState.status.isLoading
                      ? null
                      : () {
                          if (_emailEditingController.text.isEmpty) {
                            setState(() => _isEmailError = true);
                          }
                          if (_passwordEditingController.text.isEmpty) {
                            setState(() => _isPasswordError = true);
                          }
                          if (!_isPasswordError && !_isEmailError) {
                            context.read<AuthBloc>().add(AuthFetchEvent(
                                authModel: AuthModel(
                                    email: _emailEditingController.text,
                                    password:
                                        _passwordEditingController.text)));

                            context.read<AuthBloc>().stream.listen((event) {
                              if (event.status == AuthStatus.error) {
                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: (BuildContext context) =>
                                            const FailScreenView()));
                              }

                              event.status == AuthStatus.done
                                  ? Navigator.of(context).pushReplacement(
                                      CupertinoPageRoute(
                                          builder: (BuildContext context) =>
                                              BlocProvider<LogInOutBloc>(
                                                  create: (context) =>
                                                      LogInOutBloc(),
                                                  child:
                                                      const DoneScreenView())))
                                  : null;
                            });
                          }
                        },
                ),
                const SizedBox(height: 18),
                BaseTextButton(
                  title: 'Регистрация',
                  onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          const RegEmailScreenView())),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
