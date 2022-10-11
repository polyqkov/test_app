import 'package:flutter/material.dart';
import 'package:test_app/presentation/theme/app_border_radius.dart';
import 'package:test_app/presentation/theme/app_colors.dart';
import 'package:test_app/presentation/theme/app_text_styles.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.isError,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool? isError;

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
            controller: controller,
            onChanged: onChanged,
            keyboardType: TextInputType.emailAddress,
            style: AppTextStyle.calloutRegular,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: AppTextStyle.calloutRegular
                  .copyWith(color: AppColors.systemGrayLight),
              contentPadding: const EdgeInsets.only(left: 18, right: 18),
              border: OutlineInputBorder(
                borderRadius: AppBorderRaduis.defaultRaduis,
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        isError ?? false
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Некорректный или неверный Email',
                  style: AppTextStyle.footnoteRegular
                      .copyWith(color: AppColors.systemRedDark),
                ),
              )
            : Container(),
      ],
    );
  }
}
