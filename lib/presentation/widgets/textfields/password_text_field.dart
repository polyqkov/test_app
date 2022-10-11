import 'package:flutter/material.dart';
import 'package:test_app/presentation/theme/app_border_radius.dart';
import 'package:test_app/presentation/theme/app_colors.dart';
import 'package:test_app/presentation/theme/app_text_styles.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.isError,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool? isError;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.systemGray05Light,
            borderRadius: AppBorderRaduis.defaultRaduis,
          ),
          child: TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            keyboardType: TextInputType.text,
            style: AppTextStyle.calloutRegular,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: 'Пароль',
              hintStyle: AppTextStyle.calloutRegular
                  .copyWith(color: AppColors.systemGrayLight),
              contentPadding: const EdgeInsets.only(left: 18, right: 18),
              border: OutlineInputBorder(
                borderRadius: AppBorderRaduis.defaultRaduis,
                borderSide: BorderSide.none,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: obscureText
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
              ),
            ),
          ),
        ),
        widget.isError ?? false
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Некорректный или неверный Пароль',
                  style: AppTextStyle.footnoteRegular
                      .copyWith(color: AppColors.systemRedDark),
                ),
              )
            : Container(),
      ],
    );
  }
}
