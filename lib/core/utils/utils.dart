import 'dart:io';

import 'package:personal_pjt/core/theme/app_assets.dart';
import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:personal_pjt/core/theme/app_styles.dart';
import 'package:personal_pjt/global_widgets/padding_helper.dart';
import 'package:personal_pjt/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

/// [TextInputFormatter] that only accepts numbers
class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.contains(RegExp(r'D'))) {
      final TextSelection newSelection = TextSelection(
          baseOffset: newValue.selection.baseOffset - 1,
          extentOffset: newValue.selection.extentOffset - 1);
      final String newText = newValue.text.replaceAll(RegExp(r'D'), '');
      return TextEditingValue(
          text: newText, selection: newSelection, composing: TextRange.empty);
    }
    return newValue;
  }
}

class Logger {
  Logger({String? tag}) : tag = tag ?? 'Logger';

  final String tag;

  static bool get isProduction =>
      const bool.fromEnvironment('dart.vm.product');

  void d(String log) {
    if (isProduction) {
      return;
    }
    debugPrint('D/$tag : $log');
  }

  void i(String log) {
    debugPrint('I/$tag : $log');
  }

  void w(String log) {
    print(
        'W/$tag Warning ===========================================================');
    debugPrint(log);
    print(
        '==========================================================================');
  }

  void e(String log) {
    print('E/$tag ----------------------Error----------------------');
    debugPrint(log);
    print('---------------------------------------------------------');
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class Utils {
  static Future<Map<String, String>> getHeader(AccessToken token) async {
    return <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token.accessToken}',
      'device_platform': Platform.isIOS ? 'ios' : 'android'
    };
  }

  static Widget logo({required double value}) {
    return Hero(
      tag: 'hero',
      child: Image.asset('assets/logo.png', height: value),
    );
  }

  static Widget profileImage(
      {required String url, double ht = 43.0, double wt = 43.0}) {
    return Container(
      height: ht,
      width: wt,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: FadeInImage.assetNetwork(
          placeholder: AppAssets.dummyPlaceholder,
          image: url ,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Widget imageAttachment() {
    return Container(
      height: 100.0,
      width: 100.0,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage.assetNetwork(
          placeholder: AppAssets.dummyPlaceholder,
          image: AppAssets.dummyPlaceholder,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Widget carrierGuideImage(String imageURL, double height,
      {double padding = 10.0}) {
    return Container(
      height: height,
      padding: PaddingHelper.fromOnly(0, 0, 0, padding),
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage.assetNetwork(
          placeholder: AppAssets.dummyPlaceholder,
          image: imageURL ,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  static String formatCreatedAtDate({required String date}) {
    try {
      final DateTime dateObj = DateTime.parse(date).toLocal();
      final int diffDays = DateTime.now().difference(dateObj).inDays;
      final int diffHours = DateTime.now().difference(dateObj).inHours;
      final int diffMinutes = DateTime.now().difference(dateObj).inMinutes;
      final int diffSeconds = DateTime.now().difference(dateObj).inSeconds;

      if (diffHours == 0) {
        if (diffMinutes == 0)
          return '$diffSeconds Sec ago';
        else if (diffMinutes >= 1) {
          for (int i = 1; i < 60; i++) {
            if (i == diffMinutes) return '$diffMinutes Min ago';
          }
        }
      } else if (diffHours == 1) {
        return '$diffHours Hour ago';
      } else if (diffHours > 1) {
        for (int i = 1; i < 24; i++) {
          if (i == diffHours) return '$diffHours Hour ago';
        }
      }
      return new DateFormat("MMM dd 'at' hh:mm aaa").format(dateObj);
    } catch (e) {
      return '';
    }
  }

  static void showModelSheet(BuildContext context, Widget child,
      {bool dismissible = true}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: dismissible,
      isDismissible: dismissible,
      enableDrag: dismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.67,
          child: child,
        );
      },
    );
  }

  // static ProfilePicture getAttachment(String attachmentType, String base64Value,
  //     File imageFile, String fileType) {
  //   return ProfilePicture((ProfilePictureBuilder b) => b
  //     ..attachmentUrl = base64Value
  //     ..attachmentFile = imageFile
  //     ..fileType = fileType
  //     ..attachmentType = attachmentType);
  // }

  static void showPickerModelSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            height: 180.0,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0))),
            child: child,
          ),
        );
      },
    );
  }

// static Widget addButton(String name, Function onTap, double width) {
//   return Container(
//     alignment: Alignment.centerLeft,
//     width: width,
//     child: GFButton(
//       onPressed: onTap,
//       text: name,
//       color: AppColors.themeColor,
//       textStyle: AppStyle.white20MediumTextStyle.copyWith(fontSize: 15.0),
//     ),
//   );
// }
}
