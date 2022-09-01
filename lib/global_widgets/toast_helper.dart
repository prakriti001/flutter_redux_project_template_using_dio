import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ToastHelper {
  void getIntermittentToast(String text, BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.only(top: 15),
      maxWidth: 342,
      messageColor: const Color(0xFF2B2B2B),
      messageSize: 16,
      isDismissible: true,borderRadius: BorderRadius.circular(4),
      icon: Transform.scale(
          scale: 1.2,
          child: const Icon(Icons.done,color: Color(0xFF4EC17C),)),

      borderColor: const Color(0xFF4EC17C),
      message: text,
      flushbarPosition: FlushbarPosition.TOP,

      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
  void getTwoLineIntermittentToast(
      String title, String message, BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.only(top: 15),
      maxWidth: 342,
      messageColor: const Color(0xFF2B2B2B),
      messageSize: 16,
      isDismissible: true,
      borderRadius: BorderRadius.circular(4),
      icon: Transform.scale(
          scale: 1.2,
          child: const Icon(
            Icons.done,
            color: Color(0xFF4EC17C),
          )),
      borderColor: const Color(0xFF4EC17C),
      messageText: Text(
        message,
        style: const TextStyle(
            color: Color(0xFF686B7A), fontSize: 16, fontFamily: 'Regular'),
      ),
      titleText: Text(
        title,
        style: const TextStyle(
            color: Color(0xFF686B7A), fontSize: 16, fontFamily: 'SemiBold'),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
  void getIntermittentToastWithSubText(String text, BuildContext context) {
    Flushbar(
      title: 'Shift information updated.',
      titleColor:  const Color(0xFF2B2B2B),
      margin: const EdgeInsets.only(top: 15),
      maxWidth: 342,
      messageColor: const Color(0xFF2B2B2B),
      messageSize: 16,
      isDismissible: true,borderRadius: BorderRadius.circular(4),
      icon: Transform.scale(
          scale: 1.2,
          child: const Icon(Icons.done,color: Color(0xFF4EC17C),)),
      borderColor: const Color(0xFF4EC17C),
      message: text,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  void getErrorFlushBar(String text, BuildContext context) {
    Flushbar(
      maxWidth: 342,
      icon: Transform.scale(
          scale: 1.2,
          child: const Icon(Icons.error_outline,color: Color(0xFFD65641),)),
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: 24),
      flushbarStyle: FlushbarStyle.FLOATING,
      messageColor: const Color(0xFF2B2B2B),
      borderRadius: BorderRadius.circular(4),
      borderColor: Color(0xFFD65641),
      message: text,
      messageSize: 16,
      duration: const Duration(seconds: 3),
      backgroundColor:Colors.white,
      isDismissible: false,
      mainButton: TextButton(
        onPressed: () {
          Navigator.canPop(context)?Navigator.pop(context):(){};
        },
        child: Text('Ok', style: TextStyle(fontFamily: 'Regualr',fontSize: 16,color: const Color(0xFF2B2B2B),),),
      ),
    )
        .show(context);
  }
}
