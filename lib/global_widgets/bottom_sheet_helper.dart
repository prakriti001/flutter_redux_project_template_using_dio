import 'package:flutter/material.dart';

class BottomSheetHelper {
  static void showModelSheet(BuildContext context, Widget child,
      {bool dismissible = true, double? height}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: dismissible,
        isDismissible: dismissible,
        enableDrag: dismissible,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        builder: (context) {
          return height != null
              ? FractionallySizedBox(heightFactor: height, child: child)
              : child;
        });
  }

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
}
