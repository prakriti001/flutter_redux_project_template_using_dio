import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:personal_pjt/core/theme/app_assets.dart';
import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:personal_pjt/core/theme/app_styles.dart';
import 'package:personal_pjt/global_widgets/dart_helper.dart';

Size getWidgetSize(GlobalKey key) {
  final renderBox = key.currentContext?.findRenderObject() as RenderBox;
  return renderBox.size;
}

BorderRadius border(double radius) {
  return BorderRadius.all(Radius.circular(radius));
}

BoxShadow bottomNavBoxShadow() {
  return BoxShadow(
      color: AppColors.textFieldTitleColor.withOpacity(0.6), blurRadius: 15.0);
}

SizedBox getSpace(double height, double width) {
  return SizedBox(height: height, width: width);
}

SizedBox emptyBox() {
  return SizedBox(height: 0.0, width: 0.0);
}

Icon forwardArrow() {
  return Icon(Icons.arrow_forward_ios_sharp,
      color: AppColors.themeColor, size: 13.0);
}

Widget submitButton(String text, Function() onTap,
    {Color buttonColor = AppColors.themeColor}) {
  return GFButton(
    onPressed: onTap,
    text: text,
    textColor: Colors.white,
    textStyle: AppStyle.white20MediumTextStyle.copyWith(
        fontSize: 16.0,
        color: buttonColor == AppColors.themeColor
            ? Colors.white
            : AppColors.themeColor),
    color: buttonColor,
    shape: GFButtonShape.square,
    size: GFSize.LARGE,
    fullWidthButton: true,
    blockButton: true,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    borderShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

Widget getLoader(double width) {
  return Container(
    width: width,
    height: 40.0,
    decoration: BoxDecoration(
      color: AppColors.themeColor,
      borderRadius: border(8.0),
    ),
    child: loader(),
  );
}

Widget getYellowLoader(double width, {String? color}) {
  return Container(
    width: width,
    height: 38.0,
    decoration: BoxDecoration(
      color: AppColors.yellowColor,
      borderRadius: border(8.0),
    ),
    child: loader(),
  );
}

Widget loader() {
  return Image.asset(cupertinoActivityIndicator, scale: 10);
}

Widget getAppLogo(double size, {bool drawer = false}) {
  return Container(
    alignment: drawer ? Alignment.centerLeft : Alignment.center,
    height: size,
    child: Image.asset(AppAssets.appLogo),
  );
}

Widget getCircularAvatar(String url, {double radius = 30.0}) {
  return GFAvatar(
    backgroundImage:
        NetworkImage(DartHelper.isNullOrEmpty(url) ? AppAssets.userDp : url),
    radius: radius,
  );
}

Widget getCurvedSquareAvatar(String url, {double radius = 40.0}) {
  return GFAvatar(
      backgroundImage:
          NetworkImage(DartHelper.isNullOrEmpty(url) ? AppAssets.userDp : url),
      radius: radius,
      shape: GFAvatarShape.standard);
}

Widget backIcon(BuildContext context) {
  return IconButton(
    onPressed: () => Navigator.pop(context),
    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
  );
}

Widget okButton(BuildContext context, Function() onTap) {
  return Container(
    alignment: Alignment.center,
    child: GFButton(
      onPressed: onTap,
      text: 'Ok',
      color: AppColors.themeColor,
      textStyle: AppStyle.white20MediumTextStyle.copyWith(fontSize: 15.0),
    ),
  );
}

Widget getStatusIcon(bool status) {
  return status
      ? Icon(Icons.check_circle, color: AppColors.greenColor, size: 20.0)
      : Icon(Icons.cancel, color: Colors.redAccent, size: 20.0);
}

// Widget emptyStateSliverChild(String text) {
//   return SliverFillRemaining(
//     child: Center(
//       child: getTextTitle(text),
//     ),
//   );
// }

Widget globalLoader(bool isLoading) {
  return isLoading
      ? Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            color: Colors.white.withOpacity(0.001),
          ))
      : Container();
}

// Widget emptyStateSliverLoader() {
//   return SliverFillRemaining(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         loader(),
//         getTextTitle('Loading..'),
//       ],
//     ),
//   );
// }

// YYDialog globalErrorAlert(BuildContext context, String text, Function onTap) {
//   return YYDialog().build(context)
//     ..borderRadius = 0.0
//     ..barrierColor = AppColors.textFieldFillColor.withOpacity(0.1)
//     ..backgroundColor = AppColors.textFieldFillColor.withOpacity(0.1)
//     ..widget(
//       GlobalErrorAlert(text: text, onTap: onTap),
//     )
//     ..show();
// }

// YYDialog productRequestAlert(BuildContext context,
//     {String titleText = 'Your request has been submitted successfully.'}) {
//   return YYDialog().build(context)
//     ..borderRadius = 10.0
//     ..widget(
//       ProductRequestSuccessAlert(titleText: titleText),
//     )
//     ..show();
// }

Widget verifyButton(Function() onTap,
    {String title = 'e-Verify',
    Color buttonColor = AppColors.yellowColor,
    Color textColor = AppColors.themeColor}) {
  return Container(
    alignment: Alignment.center,
    child: GFButton(
      onPressed: onTap,
      text: title,
      color: buttonColor,
      textStyle: AppStyle.purple15MediumTextStyle.copyWith(color: textColor),
      fullWidthButton: true,
    ),
  );
}
