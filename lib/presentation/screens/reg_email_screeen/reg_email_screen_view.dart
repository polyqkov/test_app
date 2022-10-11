import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/internal/bloc/reg/bloc.dart';
import 'package:test_app/presentation/screens/reg_password_screen/reg_password_screen_view.dart';
import 'package:test_app/presentation/theme/app_colors.dart';
import 'package:test_app/presentation/theme/app_text_styles.dart';
import 'package:test_app/presentation/widgets/buttons/base_button.dart';
import 'package:test_app/presentation/widgets/buttons/button_animated.dart';
import 'package:test_app/presentation/widgets/textfields/email_text_field.dart';

class RegEmailScreenView extends StatefulWidget {
  const RegEmailScreenView({Key? key}) : super(key: key);

  @override
  State<RegEmailScreenView> createState() => _RegEmailScreenViewState();
}

class _RegEmailScreenViewState extends State<RegEmailScreenView> {
  late TextEditingController _emailEditingController;

  bool _isEmailError = false;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
              'Шаг 1',
              style: AppTextStyle.title1Bold,
            ),
            const SizedBox(height: 9),
            Text(
              'Введите Email',
              style: AppTextStyle.title3Medium
                  .copyWith(color: AppColors.systemGrayLight),
            ),
            const SizedBox(height: 36),
            EmailTextField(
              controller: _emailEditingController,
              isError: _isEmailError,
              onChanged: (value) => value.isEmpty
                  ? setState(() => _isEmailError = false)
                  : setState(() =>
                      _isEmailError = !EmailValidator.validate(value, true)),
            ),
            const SizedBox(height: 36),
            BaseButton(
              title: 'Продолжить',
              onTap: () {
                if (_emailEditingController.text.isEmpty) {
                  setState(() => _isEmailError = true);
                }
                if (!_isEmailError) {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            BlocProvider<RegBloc>(
                                create: (context) => RegBloc(),
                                child: RegPasswordScreenView(
                                    email: _emailEditingController.text))),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
