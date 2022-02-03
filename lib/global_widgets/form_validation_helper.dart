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

  String? passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Enter valid password.';
    } else {
      return null;
    }
  }

  String? emailValidation(String value) {
    if (!EmailValidator.validate(value)) {
      return 'Enter valid email';
    } else {
      return null;
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
