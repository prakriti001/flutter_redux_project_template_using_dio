import 'package:flutter/material.dart';

class PaddingHelper {
  static EdgeInsets fromOnly(
      double left, double top, double right, double bottom) {
    return EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
  }

  static EdgeInsets fromLTR(double value1, double value2, double value3) {
    return EdgeInsets.only(
      left: value1,
      top: value2,
      right: value3,
    );
  }

  static EdgeInsets fromRBL(double value1, double value2, double value3) {
    return EdgeInsets.only(
      right: value1,
      bottom: value2,
      left: value3,
    );
  }

  static EdgeInsets fromSymmetric(double horizontal, double vertical) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static EdgeInsets fromAll(double value) {
    return EdgeInsets.all(value);
  }
}
