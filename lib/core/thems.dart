import 'package:flutter/material.dart';

import 'colors.dart';

enum AppTheme {
  Light,
  Dark,
}

final Map<AppTheme, ThemeData> appTheme = {
  AppTheme.Light: ThemeData(
    fontFamily: 'Cairo',
    primaryColor: AppColors.myBlack,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.myTextColor,
      linearTrackColor: AppColors.myWhite,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.myRed,
    ),
    scaffoldBackgroundColor: AppColors.myRed,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.myRed,
    ),

  ),
  AppTheme.Dark: ThemeData(
    fontFamily: 'Cairo',
    primaryColor: AppColors.myWhite,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.myWhite,
      linearTrackColor: AppColors.myBlack,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.myBlack,
    ),
    scaffoldBackgroundColor: AppColors.myBlack,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.myBlack,
    ),
  ),
};
