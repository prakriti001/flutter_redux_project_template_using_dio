import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:personal_pjt/models/app_user.dart';

class CheckForUserInPrefs {}

//********************************* login-in ***********************************//
class LoginWithPassword {
  LoginWithPassword({this.email, this.mobile, this.password});

  final String? email;
  final String? mobile;
  final String? password;
}

class SaveUser {
  SaveUser({this.userDetails});

  final AppUser? userDetails;
}

//***************************** log-out ***************************************//
class LogOutUser {}

//*********************** force-log-out ***************************************//
class ForceLogOutUser {
  ForceLogOutUser({required this.error});

  final dynamic error;
}

//**************************** manage loading status *************************//
class SetLoader {
  SetLoader(this.isLoading);

  final bool isLoading;
}

//**************************** manage initializer status *************************//
class SetInitializer {
  SetInitializer(this.isInitializing);

  final bool isInitializing;
}

//**************************** manage error message ***************************//
class SetErrorMessage {
  SetErrorMessage({required this.message});

  final String message;
}
class GetUserDetails {
  final String s3BucketKey;
  GetUserDetails({required this.s3BucketKey});
}

//**************************** manage success message *************************//
class SetSuccessMessage {
  SetSuccessMessage({required this.message});

  final String message;
}
//******************************** upload-file ********************************//
class UploadFile {
  UploadFile({this.fileName, this.imageFile, this.attachment});

  final String? fileName;
  final File? imageFile;
  final ValueChanged<String>? attachment;
}
