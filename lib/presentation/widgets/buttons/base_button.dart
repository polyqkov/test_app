import 'package:flutter/cupertino.dart';
import 'package:test_app/presentation/theme/app_border_radius.dart';
import 'package:test_app/presentation/theme/app_colors.dart';
import 'package:test_app/presentation/theme/app_text_styles.dart';
import 'package:test_app/presentation/widgets/buttons/button_animated.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    required this.title,
    this.onTap,
    this.isLoading,
  }) : super(key: key);

  final String title;
  final void Function()? onTap;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return ButtonAnimated(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.systemIndigoLight,
          borderRadius: AppBorderRaduis.defaultRaduis,
        ),
        child: Center(
          child: isLoading ?? false
              ? const CupertinoActivityIndicator(
                  color: AppColors.systemGray06Light)
              : Text(
                  title,
                  style: AppTextStyle.calloutSemibold
                      .copyWith(color: AppColors.systemGray06Light),
                ),
        ),
      ),
    );
  }
}
