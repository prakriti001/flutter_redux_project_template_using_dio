import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyle {
  //**************************** white - color ********************************//

  static TextStyle white14RegularTextStyle =
      TextStyle(fontFamily: 'Regular', fontSize: 14, color: Colors.white);

  static TextStyle white14SemiboldTextStyle =
      TextStyle(fontFamily: 'SemiBold', fontSize: 14, color: Colors.white);

  static TextStyle white15RegularTextStyle =
      TextStyle(fontFamily: 'Regular', fontSize: 15, color: Colors.white);

  static TextStyle white20MediumTextStyle =
      TextStyle(fontFamily: 'Medium', fontSize: 20, color: Colors.white);

  static TextStyle white24BoldTextStyle =
      TextStyle(fontFamily: 'Bold', fontSize: 24, color: Colors.white);

  //**************************** black - color ********************************//

  static TextStyle black14RegularTextStyle = TextStyle(
      fontFamily: 'Regular', fontSize: 14, color: AppColors.textFieldTextColor);

  static TextStyle black14SemiboldTextStyle = TextStyle(
      fontFamily: 'SemiBold',
      fontSize: 14,
      color: AppColors.textFieldTextColor);

  static TextStyle black15SemiboldTextStyle = TextStyle(
      fontFamily: 'SemiBold',
      fontSize: 15,
      color: AppColors.textFieldTextColor);

  static TextStyle black28BoldTextStyle = TextStyle(
      fontFamily: 'Bold', fontSize: 28, color: AppColors.textFieldTextColor);

  static TextStyle black16MediumTextStyle = TextStyle(
      fontFamily: 'Medium', fontSize: 16, color: AppColors.textFieldTextColor);

  //***************************** grey - color ********************************//

  static TextStyle grey14RegularTextStyle = TextStyle(
      fontFamily: 'Regular',
      fontSize: 14,
      color: AppColors.textFieldTitleColor);

  //**************************** purple - color *******************************//

  static TextStyle purple28BoldTextStyle =
      TextStyle(fontFamily: 'Bold', fontSize: 28, color: AppColors.themeColor);

  static TextStyle purple32SemiboldTextStyle = TextStyle(
      fontFamily: 'SemiBold', fontSize: 32, color: AppColors.themeColor);

  static TextStyle purple16SemiBoldTextStyle = TextStyle(
      fontFamily: 'SemiBold', fontSize: 16, color: AppColors.themeColor);

  static TextStyle purple20SemiBoldTextStyle = TextStyle(
      fontFamily: 'SemiBold', fontSize: 20, color: AppColors.themeColor);

  static TextStyle purple15MediumTextStyle = TextStyle(
      fontFamily: 'Medium', fontSize: 15, color: AppColors.themeColor);
}
