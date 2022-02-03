import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

DateTime? currentBackPressTime;

class AndroidBackControl extends StatelessWidget {
  const AndroidBackControl({Key? key,required this.child,required this.onWillPop})
      : super(key: key);
  final Widget child;
  final Function onWillPop;

  Future<bool> onWillPopFun() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Press BACK again to Exit',
          backgroundColor: AppColors.themeColor,
          textColor: Colors.white);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop != null ? onWillPop() : onWillPopFun(),
      child: SafeArea(child: child),
    );
  }
}
