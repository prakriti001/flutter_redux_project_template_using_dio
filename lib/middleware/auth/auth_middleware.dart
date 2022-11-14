
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:personal_pjt/actions/actions.dart';
import 'package:personal_pjt/data/app_repository.dart';
import 'package:personal_pjt/data/services/auth/auth_service.dart';
import 'package:personal_pjt/models/models.dart';
import 'package:redux/redux.dart';

import '../../core/utils/utils.dart';
import '../../global_widgets/toast_helper.dart';
import '../../views/home/home_page.dart';


class AuthMiddleware {
  AuthMiddleware({required this.repository})
      : authService = repository.getService<AuthService>() as AuthService;

  final AppRepository repository;
  final AuthService authService;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  List<Middleware<AppState>> createAuthMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, CheckForUserInPrefs>(checkForUserInPrefs),
      TypedMiddleware<AppState, LoginWithPassword>(loginWithPassword),
      TypedMiddleware<AppState, LogOutUser>(logOutUser),
      TypedMiddleware<AppState, GetUserDetails>(getUserDetails),
      TypedMiddleware<AppState, UploadFile>(uploadFile)
    ];
  }

  void checkForUserInPrefs(Store<AppState> store, CheckForUserInPrefs action,
      NextDispatcher next) async {
    next(action);
    try {
      final AppUser? user = await repository.getUserFromPrefs();

      if (user != null) {
        store.dispatch(SetInitializer(false));
        store.dispatch(SaveUser(userDetails: user));
      } else {
        store.dispatch(SetInitializer(false));
        store.dispatch(SaveUser(userDetails: null));
      }
    } catch (e) {
      return;
    }
  }
  void getUserDetails(
      Store<AppState> store, GetUserDetails action, NextDispatcher next) async {
    try {
      store.dispatch(SetLoader(true));
Dio dio=Dio();
      final Map<String, String> headersToApi = <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer Xa_EjxATSxLVABTFpgDRAOG6A62AV7VVcUZLVHqMJNQ',
      };
      final Map<String, dynamic> objToApi = <String, dynamic>{
        'user': <String, dynamic>{
          'designation': 'dancer',

        }
      };

      final AppUser? user = await authService.getUserDetails(
          headers: headersToApi, userID: store.state.currentUser?.userId,body: objToApi,fieldName: 'display_picture_s3',
      s3BucketKey: action.s3BucketKey);

      repository.setUserPrefs(appUser: user!);
      store.dispatch(SaveUser(userDetails: user));
      store.dispatch(SetLoader(false));
    }on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print('force log out');
        store.dispatch(SetLoader(false));
        store.dispatch(ForceLogOutUser(error: true));
      }
      else{
        print('error');
        print('error:${e.response?.data['error']}');
        print('error:${e.error}');
      }
      return;
    } catch (e) {
      store.dispatch(SetLoader(false));
      store.dispatch(ForceLogOutUser(error: true));
      debugPrint(
          '============ get user details catch block ========== ${e.toString()}');
    }
    next(action);
  }

  void loginWithPassword(Store<AppState> store, LoginWithPassword action,
      NextDispatcher next) async {
    try {
      String registrationToken = '';
      store.dispatch(new SetLoader(true));
      final Map<String, dynamic> objToApi = <String, dynamic>{
        'user': <String, String>{
          'email': action.mobile ?? '',
          'password': action.password ?? '',
          'grant_type': 'email'
        }
      };
      final Map<String, dynamic>? response =
          await authService.loginWithPassword(objToApi: objToApi);
      final AppUser? user= response != null ? response['user']:null;

      if (user != null) {
        store.dispatch(SaveUser(userDetails: user));
        store.state.navigator.currentState!
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
    on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print('force logout');
        store.dispatch(SetLoader(false));
        store.dispatch(ForceLogOutUser(error: true));
      }
      else{
        print('error');
        print('error:${e.response?.data['error']}');
        print('error:${e.error}');
      }
      return;
    }catch (e) {
      store.dispatch(SetLoader(false));
      store.dispatch(ForceLogOutUser(error: true));
      debugPrint('============ login catch block ========== ${e}');
    }
    next(action);
  }
  //******************************** upload-file ********************************//
  void uploadFile(
      Store<AppState> store, UploadFile action, NextDispatcher next) async {
    try {
      store.dispatch(SetLoader(true));
      // final String? token = await repository.getUserAccessToken();
      // final Map<String, String> headersToApi = await Utils.getHeader(token!);
      final Map<String, String> headersToApi = <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer Xa_EjxATSxLVABTFpgDRAOG6A62AV7VVcUZLVHqMJNQ',
      };
      final Map<String, dynamic> objToApi = <String, dynamic>{
        "filename": action.fileName
      };
      final Map<String, dynamic>? response = await authService.uploadFile(
          headersToApi: headersToApi, objToApi: objToApi);
      final S3BucketResponse _s3BucketResponse = response!['url_fields'];
      Dio dio = Dio();
      var formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(action.imageFile!.path),
        "key": _s3BucketResponse.key,
        "success_action_status": _s3BucketResponse.successActionStatus,
        "policy": _s3BucketResponse.policy,
        "x-amz-credential": _s3BucketResponse.xAmzCredential,
        "x-amz-algorithm": _s3BucketResponse.xAmzAlgorithm,
        "x-amz-date": _s3BucketResponse.xAmzDate,
        "x-amz-signature": _s3BucketResponse.xAmzSignature
      });
      var s3BucketResponse = await dio.post(response['url'], data: formData);
      if (s3BucketResponse.statusCode == 201) {
        final document = s3BucketResponse.data.toString();
        debugPrint(
            document.toString().split('<Key>').last.split('</Key>').first);
        action.attachment!(
            document.toString().split('<Key>').last.split('</Key>').first);
      }
      store.dispatch(SetLoader(false));
    } on ApiError catch (e) {
      store.dispatch(SetLoader(false));
      ToastHelper().getErrorFlushBar(
          e.errorMessage!, store.state.navigator.currentContext!);
      return;
    } catch (e) {
      store.dispatch(SetLoader(false));
      store.dispatch(ForceLogOutUser(error: true));
      debugPrint(
          '============ upload file catch block ========== ${e.toString()}');
    }
    next(action);
  }


  void logOutUser(
      Store<AppState> store, LogOutUser action, NextDispatcher next) async {
    repository.setUserPrefs(appUser: null);
    store.dispatch(SaveUser(userDetails: null));
    next(action);
  }
  void _setUpFireBase() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<String?> _getFCMToken() async {
    String registrationToken = '';
    try {
      await messaging.getToken().then((String? token) {
        debugPrint('--------->>>\n$token\n<<<<<---------');
        registrationToken = token!;
      });
      return registrationToken;
    } catch (e) {
      debugPrint(
          '======================= error in getting the token ===============');
    }
  }
}
