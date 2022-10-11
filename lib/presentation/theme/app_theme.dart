import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

final appTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.systemGray06Light,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.systemGray06Light,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.systemIndigoLight,
    selectionColor: AppColors.systemIndigoLight.withOpacity(0.4),
    selectionHandleColor: AppColors.systemIndigoLight,
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    color: AppColors.systemGray06Light,
    elevation: 0,
    titleTextStyle: AppTextStyle.title2Medium,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: AppColors.systemGray06Light,
    elevation: 0,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.systemIndigoLight,
    onPrimary: AppColors.systemGray06Dark,
    secondary: AppColors.systemGray04Light,
    onSecondary: AppColors.systemGray06Dark,
    error: AppColors.systemRedDark,
    onError: AppColors.white,
    background: AppColors.systemGray06Light,
    onBackground: AppColors.systemGray06Dark,
    surface: AppColors.systemGray06Light,
    onSurface: AppColors.systemGray06Dark,
    primaryContainer: AppColors.systemGray06Light,
  ),
);
