library theme;

import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:personal_pjt/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: AppColors.themeColor,
    scaffoldBackgroundColor: AppColors.bgColor,
    accentColor: AppColors.themeColor,
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.themeColor,
      textTheme: ButtonTextTheme.primary,
    ),
    sliderTheme: SliderThemeData(
        showValueIndicator: ShowValueIndicator.always
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.textFieldFillColor,
        hintStyle: AppStyle.black14RegularTextStyle,
        contentPadding: EdgeInsets.all(13.0),
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide:
                BorderSide(width: 0.7, color: AppColors.textFieldBorderColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                width: 0.7, color: Colors.redAccent.withOpacity(0.8))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide:
                BorderSide(width: 0.7, color: AppColors.textFieldBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide:
                BorderSide(width: 0.7, color: AppColors.textFieldBorderColor))),
    primarySwatch: MaterialColor(0XFF363A7C, color),
    iconTheme: IconThemeData(color: AppColors.themeColor, size: 24.0));
Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
