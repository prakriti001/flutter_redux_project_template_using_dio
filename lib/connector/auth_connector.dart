import 'dart:io';

import 'package:personal_pjt/actions/actions.dart';
import 'package:personal_pjt/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

part 'auth_connector.g.dart';
typedef GetUserDetailsAction=void Function({required String s3BucketKey});
typedef LoginWithPasswordAction = void Function(
    String email, String mobile, String password);
typedef LogOutAction = void Function();
typedef UploadFileAction = void Function(
    String? fileName, File? imageFile, ValueChanged<String>? attachment);
abstract class AuthViewModel
    implements Built<AuthViewModel, AuthViewModelBuilder> {
  factory AuthViewModel(
      [AuthViewModelBuilder Function(AuthViewModelBuilder builder)
          updates]) = _$AuthViewModel;

  AuthViewModel._();

  factory AuthViewModel.fromStore(Store<AppState> store) {
    return AuthViewModel((AuthViewModelBuilder b) {
      return b
        ..isInitializing = store.state.isInitializing
        ..currentUser = store.state.currentUser?.toBuilder()
        ..loginWithPassword = (String email, String mobile, String password) {
          store.dispatch(LoginWithPassword(
              email: email, mobile: mobile, password: password));
        }
        ..getUserDetailsAction=({required String s3BucketKey}){
          store.dispatch(GetUserDetails(s3BucketKey: s3BucketKey));
        }
        ..uploadFileAction = (String? fileName, File? imageFile,
            ValueChanged<String>? attachment) {
          store.dispatch(UploadFile(
              fileName: fileName,
              imageFile: imageFile,
              attachment: attachment));}
        ..logOut = () {
          store.dispatch(LogOutUser());
        };
    });
  }
GetUserDetailsAction get getUserDetailsAction;
  LoginWithPasswordAction get loginWithPassword;

  LogOutAction get logOut;
  UploadFileAction get uploadFileAction;
  AppUser? get currentUser;

  bool get isInitializing;
}

class AuthConnector extends StatelessWidget {
  const AuthConnector({required this.builder});

  final ViewModelBuilder<AuthViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthViewModel>(
      builder: builder,
      converter: (Store<AppState> store) => AuthViewModel.fromStore(store),
    );
  }
}
