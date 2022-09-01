import 'package:email_validator/email_validator.dart';
import 'package:personal_pjt/global_widgets/dart_helper.dart';
import 'package:flutter/material.dart';

class FormValidationHelper {
  String? mobileValidation(String value) {
    if (!DartHelper.isMobileNumber(value)) {
      return 'Enter valid mobile.';
    } else {
      return null;
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool? passwordValidation(String value) {
    if (value.isNotEmpty && !validateStructure(value)) {
      return false;
    } else {
      return true;
    }
  }

  bool emailValidation(String value) {
    if (value.isNotEmpty &&
        !(RegExp(
            r"^[a-z0-9!#$%&'*+/=?^_{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)\b")
            .hasMatch(value))) {
      return false;
    } else {
      return true;
    }
  }

  String? confirmPasswordValidation(String pass, String newPass) {
    if (pass != newPass) {
      return 'Both passwords should match.';
    } else {
      return null;
    }
  }

  String? otpValidation(String value, int lenght) {
    if (value.length != lenght) {
      return 'Enter valid passcode';
    } else {
      return null;
    }
  }

  String? emptyValidation(String value, String errorMessage) {
    if (value.isEmpty) {
      return errorMessage;
    } else {
      return null;
    }
  }

  bool loginFormValidation(GlobalKey<FormState> loginFormKey) {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }
}
