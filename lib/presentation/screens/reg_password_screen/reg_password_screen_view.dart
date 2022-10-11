import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/data/api/models/reg_model.dart';
import 'package:test_app/internal/bloc/login_in/bloc.dart';
import 'package:test_app/internal/bloc/reg/bloc.dart';
import 'package:test_app/presentation/screens/done_screen/done_screen_view.dart';
import 'package:test_app/presentation/theme/app_colors.dart';
import 'package:test_app/presentation/theme/app_text_styles.dart';
import 'package:test_app/presentation/widgets/buttons/base_button.dart';
import 'package:test_app/presentation/widgets/buttons/button_animated.dart';
import 'package:test_app/presentation/widgets/textfields/password_confirm_text_field.dart';
import 'package:test_app/presentation/widgets/textfields/password_text_field.dart';
import 'package:test_app/presentation/widgets/toast/base_toast.dart';

class RegPasswordScreenView extends StatefulWidget {
  const RegPasswordScreenView({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  State<RegPasswordScreenView> createState() => _RegPasswordScreenViewState();
}

class _RegPasswordScreenViewState extends State<RegPasswordScreenView> {
  late TextEditingController _passwordEditingController;
  late TextEditingController _passwordConfirmEditingController;

  bool _isPasswordError = false;
  bool _isPasswordConfirmError = false;

  @override
  void initState() {
    super.initState();
    _passwordEditingController = TextEditingController();
    _passwordConfirmEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegBloc, RegState>(
      builder: (context, regState) {
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
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.topLeft,
                  child: ButtonAnimated(
                    child: const Icon(Icons.arrow_back_ios_rounded),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 54),
                const Text(
                  'Шаг 2',
                  style: AppTextStyle.title1Bold,
                ),
                const SizedBox(height: 9),
                Text(
                  'Введите Пароль',
                  style: AppTextStyle.title3Medium
                      .copyWith(color: AppColors.systemGrayLight),
                ),
                const SizedBox(height: 36),
                PasswordTextField(
                  controller: _passwordEditingController,
                  isError: _isPasswordError,
                  onChanged: (value) {
                    value.isEmpty
                        ? setState(() => _isPasswordError = true)
                        : setState(() => _isPasswordError = false);

                    value != _passwordConfirmEditingController.text
                        ? setState(() => _isPasswordConfirmError = true)
                        : setState(() => _isPasswordConfirmError = false);
                  },
                ),
                const SizedBox(height: 18),
                PasswordConfirmTextField(
                  controller: _passwordConfirmEditingController,
                  isError: _isPasswordConfirmError,
                  onChanged: (value) => value != _passwordEditingController.text
                      ? setState(() => _isPasswordConfirmError = true)
                      : setState(() => _isPasswordConfirmError = false),
                ),
                const SizedBox(height: 36),
                BaseButton(
                  title: 'Завершить',
                  isLoading: regState.status.isLoading,
                  onTap: () {
                    if (_passwordEditingController.text.isEmpty) {
                      setState(() => _isPasswordError = true);
                    }
                    if (!_isPasswordError && !_isPasswordConfirmError) {
                      context.read<RegBloc>().add(RegFetchEvent(
                          regModel: RegModel(
                              email: widget.email,
                              password: _passwordEditingController.text)));

                      context.read<RegBloc>().stream.listen((event) {
                        event.status.isError
                            ? BaseToast.show(event.error ?? "")
                            : null;
                        event.status.isDone
                            ? Navigator.of(context).pushReplacement(
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        BlocProvider<LogInOutBloc>(
                                            create: (context) => LogInOutBloc(),
                                            child: const DoneScreenView())))
                            : null;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
