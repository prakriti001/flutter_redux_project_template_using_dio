import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:personal_pjt/core/theme/app_styles.dart';
import 'package:personal_pjt/global_widgets/padding_helper.dart';
import 'package:personal_pjt/global_widgets/widget_helper.dart';
import 'package:flutter/material.dart';

Widget getLoginText(String textValue) {
  final text = Text(
    textValue,
    style: AppStyle.purple32SemiboldTextStyle,
    overflow: TextOverflow.fade,
    softWrap: true,
  );
  return text;
}

Widget getTextFieldTitle(String textValue) {
  final text = Text(
    textValue,
    style: AppStyle.grey14RegularTextStyle,
    overflow: TextOverflow.fade,
    softWrap: true,
  );
  return text;
}

Widget getTextTitleCenter(String textValue) {
  final text = Text(
    textValue,
    style: AppStyle.black14RegularTextStyle,
    overflow: TextOverflow.fade,
    softWrap: true,
    textAlign: TextAlign.center,
  );
  return text;
}

Widget getTextTitle(String textValue) {
  final text = Text(
    textValue,
    style: AppStyle.black14RegularTextStyle,
    overflow: TextOverflow.fade,
    softWrap: true,
  );
  return text;
}

Widget termsCondTitle(String textValue) {
  final text = Text(
    textValue,
    style: AppStyle.black14RegularTextStyle,
    overflow: TextOverflow.fade,
    textAlign: TextAlign.justify,
  );
  return text;
}

Widget getErrorText(String textValue) {
  final text = Text(
    textValue,
    style: AppStyle.black14RegularTextStyle.copyWith(color: Colors.redAccent),
    overflow: TextOverflow.fade,
    softWrap: true,
  );
  return text;
}

Widget appBarText(String textValue) {
  final text = Text(
    textValue,
    style: AppStyle.white20MediumTextStyle.copyWith(fontSize: 24.0),
    overflow: TextOverflow.clip,
  );
  return text;
}

Widget loanAppBarText(String textValue) {
  final text = Text(
    textValue,
    style: AppStyle.white20MediumTextStyle.copyWith(fontSize: 21.0),
    overflow: TextOverflow.clip,
  );
  return text;
}

Widget titleText(String text) {
  return Text(
    text,
    style: AppStyle.purple16SemiBoldTextStyle,
    overflow: TextOverflow.ellipsis,
    softWrap: true,
  );
}

Widget titleTextWithOutWrap(String text) {
  return Text(
    text,
    style: AppStyle.purple16SemiBoldTextStyle,
  );
}

Widget purpleTitleText(String text) {
  return Text(
    text,
    style: AppStyle.purple28BoldTextStyle.copyWith(fontSize: 18.0),
    overflow: TextOverflow.ellipsis,
    softWrap: true,
  );
}

Widget titleTextWithAsterisk(String text) {
  return RichText(
    text:
        TextSpan(text: text, style: AppStyle.grey14RegularTextStyle, children: [
      TextSpan(text: ' *', style: TextStyle(color: Colors.red, fontSize: 20.0))
    ]),
  );
}

Widget subTitleText(String text) {
  return Text(
    text,
    style: AppStyle.grey14RegularTextStyle,
    overflow: TextOverflow.ellipsis,
    softWrap: true,
  );
}

Widget dataText(String text) {
  return Text(
    text,
    style: AppStyle.black15SemiboldTextStyle,
    softWrap: true,
  );
}

Widget basicColumn(String title, String text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [subTitleText(title), getSpace(5.0, 0.0), dataText(text)],
  );
}

Widget basicColumnWithIcon(String title, String text, Function() onTap) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          subTitleText(title),
          IconButton(
              onPressed: onTap,
              visualDensity: VisualDensity.compact,
              padding: PaddingHelper.fromAll(0.0),
              icon: Icon(Icons.info, color: AppColors.blueColor, size: 20.0))
        ],
      ),
      dataText(text)
    ],
  );
}

Widget profileUserNameText(String title) {
  return Text(title,
      style: AppStyle.white20MediumTextStyle.copyWith(fontSize: 24.0));
}

Widget profileEmailPhoneNoText(String title) {
  return Text(title, style: AppStyle.white15RegularTextStyle);
}

Widget TermsConText(String text) {
  return Text(
    text,
    style: AppStyle.black15SemiboldTextStyle,
    softWrap: true,
  );
}

Widget profileCreatedText(String text) {
  return Text(
    'This profile was created by $text',
    style:
        AppStyle.black14RegularTextStyle.copyWith(color: AppColors.themeColor),
    softWrap: true,
  );
}

Widget carrerTitleText(String title) {
  return Text(
    title,
    style: AppStyle.black16MediumTextStyle.copyWith(fontSize: 15.0),
    overflow: TextOverflow.fade,
    softWrap: true,
  );
}

Widget carrerTotalText(String text) {
  return Text(
    text,
    style: AppStyle.purple28BoldTextStyle.copyWith(fontSize: 18.0),
    softWrap: true,
  );
}

Widget getBajajPdtText(String textValue) {
  final text = Text(
    textValue,
    style: AppStyle.black16MediumTextStyle.copyWith(fontSize: 15.0),
    overflow: TextOverflow.fade,
    softWrap: true,
  );
  return text;
}

Widget bajajTitleText(String text) {
  return Text(text, style: AppStyle.grey14RegularTextStyle);
}

Widget purpleText(String text) {
  return Text(text,
      style: AppStyle.purple15MediumTextStyle.copyWith(fontSize: 15.0));
}

Widget blackRegularText(String text) {
  return Text(text,
      style: AppStyle.black14RegularTextStyle.copyWith(fontSize: 15.0));
}
