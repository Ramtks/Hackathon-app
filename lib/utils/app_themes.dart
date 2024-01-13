import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_app/utils/app_colors.dart';

class AppThemes {
  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.transparent,
        disabledForegroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
    ),
    splashColor: AppColors.splashColor,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.mainTextColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Vazirmatn',
        fontWeight: FontWeight.normal,
        fontSize: 16,
        color: AppColors.mainTextColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 16,
        color: AppColors.mainTextColor,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.mainTextColor,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Vazirmatn',
        fontWeight: FontWeight.normal,
        fontSize: 18,
        color: AppColors.mainTextColor,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Vazirmatn',
        fontWeight: FontWeight.normal,
        color: AppColors.mainTextColor,
        fontSize: 14,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Vazirmatn',
        fontWeight: FontWeight.normal,
        color: AppColors.mainTextColor,
        fontSize: 12,
      ),
      titleLarge: TextStyle(fontFamily: 'Vazirmatn', fontSize: 16),
      headlineSmall: TextStyle(
        fontFamily: 'Vazirmatn',
        color: AppColors.mainTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
