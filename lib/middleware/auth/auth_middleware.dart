
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:personal_pjt/actions/actions.dart';
import 'package:personal_pjt/data/app_repository.dart';
import 'package:personal_pjt/data/services/auth/auth_service.dart';
import 'package:personal_pjt/models/models.dart';
import 'package:redux/redux.dart';

import '../../views/home/home_page.dart';


class AuthMiddleware {
  AuthMiddleware({required this.repository})
      : authService = repository.getService<AuthService>() as AuthService;

  final AppRepository repository;
  final AuthService authService;

  List<Middleware<AppState>> createAuthMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, CheckForUserInPrefs>(checkForUserInPrefs),
      TypedMiddleware<AppState, LoginWithPassword>(loginWithPassword),
      TypedMiddleware<AppState, LogOutUser>(logOutUser),
      TypedMiddleware<AppState, GetUserDetails>(getUserDetails)
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
        'Authorization': 'Bearer P1lkSkOQ-G5vuRvlJxNIzv0Sc2DIs118nqtEm_l2TSQ',
      };
      final Map<String, dynamic> objToApi = <String, dynamic>{
        'user': <String, dynamic>{
          'designation': 'dancer',

        }
      };

      final AppUser? user = await authService.getUserDetails(
          headers: headersToApi, userID: store.state.currentUser?.userId,body: objToApi,fileNames: ['image_cropper_1661424285093.jpg'],
      filePath: [action.path]);

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

  void logOutUser(
      Store<AppState> store, LogOutUser action, NextDispatcher next) async {
    repository.setUserPrefs(appUser: null);
    store.dispatch(SaveUser(userDetails: null));
    next(action);
  }
}
