
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
      TypedMiddleware<AppState, UploadFile>(uploadFile),
      TypedMiddleware<AppState, ForceLogOutUser>(forceLogOutUser),
      TypedMiddleware<AppState, LoginWithRefreshToken>(loginWithRefreshToken)
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
      store.dispatch(new SetLoader(false));
      return;
    }
  }

  void getUserDetails(Store<AppState> store, GetUserDetails action,
      NextDispatcher next) async {
    try {
      store.dispatch(SetLoader(true));
      Dio dio = Dio();
      final AccessToken? token = await repository.getUserAccessToken();
      final Map<String, String> headersToApi = await Utils.getHeader(token!);

      final Map<String, dynamic> objToApi = <String, dynamic>{
        'user': <String, dynamic>{
          'designation': 'dancer',
        }
      };

      final AppUser? user = await authService.getUserDetails(
          headers: headersToApi,
          userID: store.state.currentUser?.userId,
          body: objToApi,
          fieldName: 'display_picture_s3',
          s3BucketKey: action.s3BucketKey);
      if(user != null) {
        repository.setUserPrefs(appUser: user);
        store.dispatch(SaveUser(userDetails: user));
      }
      if(action.callbackFunc != null) {
        action.callbackFunc!();
      }
      store.dispatch(SetLoader(false));
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print('===========Unauthorized user-------Login with refresh token===========');
        store.dispatch(ForceLogOutUser(error: true, callbackFunc: () {
          store.dispatch(GetUserDetails(callbackFunc: action.callbackFunc,
              s3BucketKey: action.s3BucketKey));
        }));
      }
      else {
        store.dispatch(SetLoader(false));
        print('error');
        print('error:${e.response?.data['error']}');
        print('error:${e.error}');
        ToastHelper().getErrorFlushBar(
            e.message, store.state.navigator.currentContext!);
      }
      return;
    } catch (e) {
      store.dispatch(SetLoader(false));
      debugPrint(
          '============ get user details catch block ========== ${e
              .toString()}');
      ToastHelper().getErrorFlushBar(
          e.toString(), store.state.navigator.currentContext!);
    }
    next(action);
  }

  void loginWithPassword(Store<AppState> store, LoginWithPassword action,
      NextDispatcher next) async {
    try {
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

      if (response != null) {
        final AppUser? user = response['customer'];
        final AccessToken? token = response['token'];
        repository.setUserPrefs(appUser: user);
        repository.setUserAccessToken(accessToken: token);

        if (user != null) {
          store.dispatch(SaveUser(userDetails: user));
          store.state.navigator.currentState!
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        }
      }
      store.dispatch(new SetLoader(false));
    }
    on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print('force logout');
      }
      else {
        print('error');
        print('error:${e.response?.data['error']}');
        print('error:${e.error}');
      }
      store.dispatch(new SetLoader(false));
      store.dispatch(ForceLogOutUser(error: e.message, forceLogout: true));
      return;
    } catch (e) {
      store.dispatch(new SetLoader(false));
      store.dispatch(ForceLogOutUser(error: e, forceLogout: true));
      debugPrint('============ login catch block ========== ${e}');
    }
    next(action);
  }

  //******************************** upload-file ********************************//
  void uploadFile(Store<AppState> store, UploadFile action,
      NextDispatcher next) async {
    try {
      store.dispatch(SetLoader(true));
      final AccessToken? token = await repository.getUserAccessToken();
      final Map<String, String> headersToApi = await Utils.getHeader(token!);

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
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print('===========Unauthorized user-------Login with refresh token===========');
        store.dispatch(ForceLogOutUser(error: true, callbackFunc: () {
          store.dispatch(UploadFile(fileName: action.fileName,
              imageFile: action.imageFile, attachment: action.attachment));
        }));
      }
      else {
        store.dispatch(SetLoader(false));
        print('error');
        print('error:${e.response?.data['error']}');
        print('error:${e.error}');
        ToastHelper().getErrorFlushBar(
            e.message, store.state.navigator.currentContext!);
      }
      return;
    } catch (e) {
      store.dispatch(SetLoader(false));
      debugPrint(
          '============ upload file catch block ========== ${e
              .toString()}');
      ToastHelper().getErrorFlushBar(
          e.toString(), store.state.navigator.currentContext!);
    }

    // on ApiError catch (e) {
    //   store.dispatch(SetLoader(false));
    //   ToastHelper().getErrorFlushBar(
    //       e.errorMessage!, store.state.navigator.currentContext!);
    //   return;
    // } catch (e) {
    //   store.dispatch(SetLoader(false));
    //   store.dispatch(ForceLogOutUser(error: true));
    //   debugPrint(
    //       '============ upload file catch block ========== ${e.toString()}');
    // }
    next(action);
  }

  //******************************** login-with-refresh-token ********************************//
  void loginWithRefreshToken(Store<AppState> store,
      LoginWithRefreshToken action,
      NextDispatcher next) async {
    try {
      store.dispatch(new SetLoader(true));
      Dio dio = Dio();
      final AccessToken? token = await repository.getUserAccessToken();

      final Map<String, dynamic> objToApi = <String, dynamic>{
        'user': <String, String>{
          'grant_type': 'refresh_token',
          'refresh_token': token?.refreshToken ?? "",
        }
      };
      final Map<String, dynamic>? response =
      await authService.loginWithPassword(objToApi: objToApi);

      if (response != null) {
        final AppUser? user = response['customer'];
        final AccessToken? token = response['token'];
        repository.setUserPrefs(appUser: user);
        repository.setUserAccessToken(accessToken: token);

        if (user != null) {
          store.dispatch(SaveUser(userDetails: user));
          store.state.navigator.currentState!
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        }
        if(action.callbackFunc != null) {
          action.callbackFunc!();
        }
      }
      store.dispatch(new SetLoader(false));
    }
    on DioError catch (e) {
      store.dispatch(SetLoader(false));
      store.dispatch(ForceLogOutUser(error: e.message, forceLogout: true));
      debugPrint('============ login with refresh token error block ========== ${e}');
      return;
    } catch (e) {
      store.dispatch(SetLoader(false));
      store.dispatch(ForceLogOutUser(error: e, forceLogout: true));
      debugPrint('============ login with refresh token catch block ========== ${e}');
    }
    next(action);
  }

  //******************************** logout-user ********************************//
  void logOutUser(Store<AppState> store, LogOutUser action,
      NextDispatcher next) async {
    try {
      store.dispatch(SetLoader(true));
      Dio dio = Dio();

      final AccessToken? token = await repository.getUserAccessToken();
      final Map<String, String> headersToApi = await Utils.getHeader(token!);
      await authService.logOutUser(headers: headersToApi);

      repository.setUserPrefs(appUser: AppUser());
      repository.setUserAccessToken(accessToken: AccessToken());
      store.dispatch(SaveUser(userDetails: AppUser()));
      store.dispatch(SetLoader(false));
    } on DioError catch (e) {
      store.dispatch(SetLoader(false));
      store.dispatch(ForceLogOutUser(error: e.message, forceLogout: true));
      debugPrint('============ logout user error block ========== ${e}');
      return;
    } catch (e) {
      store.dispatch(SetLoader(false));
      store.dispatch(ForceLogOutUser(error: e, forceLogout: true));
      debugPrint('============ logout user catch block ========== ${e}');
    }
    next(action);
  }

  //**************************** force-logout-user ****************************//
  void forceLogOutUser(Store<AppState> store, ForceLogOutUser action,
      NextDispatcher next) async {
    try {
      store.dispatch(SetLoader(true));

      ///force log out the user
      if (action.forceLogout == true) {
        repository.setUserPrefs(appUser: AppUser());
        repository.setUserAccessToken(accessToken: AccessToken());
        store.dispatch(SaveUser(userDetails: AppUser()));
        store.state.navigator.currentState!
            .pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      }

      ///login with refresh token
      else if (action.error == true) {
        store.dispatch(
            LoginWithRefreshToken(callbackFunc: action.callbackFunc));
      } else {
        debugPrint('------------------${action.error.toString()}');
      }
    } catch (e) {
      store.dispatch(SetLoader(false));
      debugPrint('force-logout catch block ${e.toString()}');
    }
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
