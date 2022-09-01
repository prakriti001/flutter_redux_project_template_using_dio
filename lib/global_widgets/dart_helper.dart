import 'package:built_collection/built_collection.dart';
import 'package:personal_pjt/core/values/app_constants.dart';
import 'package:flutter/material.dart';

class DartHelper {
  static bool isNullOrEmpty(String value) => value == '' || value == null;

  static MaterialPageRoute pushMethod(dynamic value) =>
      MaterialPageRoute<void>(builder: (BuildContext context) => value);

  static bool isMobileNumber(String value) =>
      RegExp(AppConstants.MobileNumberPattern).hasMatch(value);

  static bool isIFSCCode(String value) =>
      RegExp(AppConstants.IFSCCodePattern).hasMatch(value);

  static bool isNullOrEmptyList(BuiltList<dynamic> list) =>
      list.length == 0 || list == null || list.isEmpty;

  static bool isNullOrEmptyLists(List<dynamic> list) =>
      list.length == 0 || list == null || list.isEmpty;
}