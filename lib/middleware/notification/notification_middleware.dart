import 'package:built_collection/built_collection.dart';
import 'package:personal_pjt/actions/actions.dart';
import 'package:personal_pjt/core/utils/utils.dart';
import 'package:personal_pjt/data/app_repository.dart';
import 'package:personal_pjt/data/services/notification/notification_service.dart';
import 'package:personal_pjt/models/models.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class NotificationMiddleware {
  NotificationMiddleware({required this.repository})
      : notificationService =
            repository.getService<NotificationService>() as NotificationService;

  final AppRepository repository;
  final NotificationService notificationService;

  List<Middleware<AppState>> createAuthMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, NotificationList>(notificationList),
      TypedMiddleware<AppState, UpdateNotificationReadStatus>(
          updateNotificationReadStatus),
    ];
  }

//**************************** get-notifications-list *************************//
  void notificationList(Store<AppState> store, NotificationList action,
      NextDispatcher next) async {
    try {
      store.dispatch(SetLoader(true));

      final AccessToken? token = await repository.getUserAccessToken();
      final Map<String, String> headersToApi = await Utils.getHeader(token!);
      final Map<String, Object> apiResponse =
          await notificationService.getNotificationsList(
        headersToApi: headersToApi,
        pageNo: action.pageNo,
      );
      final BuiltList<Notifications>? notificationList =
          apiResponse['notifications'] as BuiltList<Notifications>;
      final Pagination? pagination = apiResponse['meta'] as Pagination;
      store.dispatch(SaveNotificationPagination(pagination: pagination));
      List<Notifications>? dataToState = <Notifications>[];
      if (action.pageNo == 1) {
        dataToState = notificationList!.toList();
      } else if (action.pageNo! > 1) {
        dataToState = store.state.notificationList!.toList()
          ..addAll(notificationList!.toList());
      }
      store.dispatch(SaveNotificationList(
        notificationList: dataToState.toBuiltList(),
      ));
      store.dispatch(SaveOnMessageCount(onMessageCount: 0));
      store.dispatch(SetLoader(false));
    } on ApiError catch (e) {
      store.dispatch(SetLoader(false));
      // globalErrorAlert(
      //     store.state.navigator.currentContext, e?.errorMessage, null);
      store.dispatch(new ForceLogOutUser(error: e));
      return;
    } catch (e) {
      store.dispatch(SetLoader(false));
      store.dispatch(ForceLogOutUser(error: true));
      debugPrint(
          '============ get notifications list catch block ========== ${e?.toString()}');
    }
    next(action);
  }

//************************** update-read-status-notification ******************//
  void updateNotificationReadStatus(Store<AppState> store,
      UpdateNotificationReadStatus action, NextDispatcher next) async {
    try {
      store.dispatch(new SetLoader(true));
      final AccessToken? token = await repository.getUserAccessToken();
      final Map<String, String> headersToApi = await Utils.getHeader(token!);
      final Notifications notification =
          await notificationService.updateNotificationReadStatus(
              headersToApi: headersToApi,
              notificationID: action.notificationID);
      ListBuilder<Notifications> notificationList =
          store.state.notificationList!.toBuilder();
      int? index = store.state.notificationList
          ?.indexWhere(((Notifications gp) => gp.id == action.notificationID));
      if (index! >= 0) {
        notificationList[index] = notification;
      }
      store.dispatch(SaveNotificationList(
        notificationList: notificationList.build(),
      ));
      // PaginationBuilder paginationBuilder =
      // store?.state?.notificationPagination?.toBuilder();
      // paginationBuilder
      //   ..notificationCount =
      //   (store?.state?.notificationPagination?.notificationCount - 1);
      // store.dispatch(
      //     SaveNotificationPagination(pagination: paginationBuilder?.build()));
      store.dispatch(new SetLoader(false));
    } on ApiError catch (e) {
      store.dispatch(SetLoader(false));
      // globalErrorAlert(
      //     store.state.navigator.currentContext, e?.errorMessage, null);
      store.dispatch(new ForceLogOutUser(error: e));
      return;
    } catch (e) {
      store.dispatch(SetLoader(false));
      store.dispatch(ForceLogOutUser(error: true));
      debugPrint(
          '============ update read count notifications catch block ========== ${e?.toString()}');
    }
    next(action);
  }
}
