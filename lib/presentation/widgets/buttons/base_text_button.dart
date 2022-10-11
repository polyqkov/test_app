import 'package:flutter/material.dart';
import 'package:test_app/presentation/theme/app_border_radius.dart';
import 'package:test_app/presentation/theme/app_colors.dart';
import 'package:test_app/presentation/theme/app_text_styles.dart';
import 'package:test_app/presentation/widgets/buttons/button_animated.dart';

class BaseTextButton extends StatelessWidget {
  const BaseTextButton({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ButtonAnimated(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.systemGray04Light,
          borderRadius: AppBorderRaduis.defaultRaduis,
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.calloutSemibold
                .copyWith(color: AppColors.systemIndigoLight),
          ),
        ),
      ),
    );
  }
}
