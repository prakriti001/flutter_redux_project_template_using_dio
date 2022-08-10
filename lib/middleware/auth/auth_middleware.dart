
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:personal_pjt/actions/actions.dart';
import 'package:personal_pjt/data/app_repository.dart';
import 'package:personal_pjt/data/services/auth/auth_service.dart';
import 'package:personal_pjt/models/models.dart';
import 'package:redux/redux.dart';


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
      final Map<String, String> headersToApi = <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 9o0X20-Z0PZREaQs2sccaIoYbqXSdzeM8051P0RTeMQ',
      };
      final AppUser? user = await authService.getUserDetails(
          headers: headersToApi, userID: store.state.currentUser?.userId);

      repository.setUserPrefs(appUser: user!);
      store.dispatch(SaveUser(userDetails: user));
      store.dispatch(SetLoader(false));
    } on ApiError catch (e) {
      store.dispatch(SetLoader(false));
      store.state.navigator.currentState!.pop();
      store.dispatch(ForceLogOutUser(error: e));
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
          'email': "pasupathypa@gmail.com",
          'password': "Admin@123",
          'grant_type': 'email'
        }
      };
      final Map<String, dynamic> response =
          await authService.loginWithPassword(objToApi: objToApi);
      final AppUser user=response['user'];
       print(user.userId);
      //
      //  final AppUser user = response['customer'];
      // // print('${user.userId}');
      // print("==========first==============${user.toString()}");
      // print(
      //     "=========second===================${response['customer'].toString()}");
      // if (user != null) {
      //   store.dispatch(SaveUser(userDetails: user));
      //   store.state.navigator.currentState!
      //       .push(MaterialPageRoute(builder: (context) => HomePage()));
      //   print(
      //       "=============in state =========${store.state.currentUser.toString()}");
    }
    on DioError catch (e) {
      store.dispatch(SetLoader(false));
    print('error:${e.response?.data['error']}');
      return;
    } catch (e) {
      store.dispatch(SetLoader(false));
      store.dispatch(ForceLogOutUser(error: true));
      debugPrint('============ login catch block ========== ${e}');
    }
    store.dispatch(SetLoader(false));

    // } on ApiError catch (e) {
    //   debugPrint('============ login error block ========== ${e.toString()}');
    //   store.dispatch(SetLoader(false));
    //   //  globalErrorAlert(
    //   //      store.state.navigator.currentContext, e?.errorMessage, null);
    //   return;
    // } catch (e) {
    //   store.dispatch(SetLoader(false));
    //   debugPrint('============ login catch block ========== ${e.toString()}');
    // }
    // next(action);
  }

  void logOutUser(
      Store<AppState> store, LogOutUser action, NextDispatcher next) async {
    repository.setUserPrefs(appUser: null);
    store.dispatch(SaveUser(userDetails: null));
    next(action);
  }
}
