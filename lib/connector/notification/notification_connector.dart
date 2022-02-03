import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:personal_pjt/actions/actions.dart';
import 'package:personal_pjt/models/models.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

part 'notification_connector.g.dart';

typedef NotificationListAction = void Function(int pageNo);
typedef UpdateNotificationReadStatusAction = void Function(int notificationID);

abstract class NotificationModel
    implements Built<NotificationModel, NotificationModelBuilder> {
  factory NotificationModel(
      [NotificationModelBuilder updates(
          NotificationModelBuilder builder)]) = _$NotificationModel;

  NotificationModel._();

  factory NotificationModel.fromStore(Store<AppState> store) {
    return NotificationModel((NotificationModelBuilder b) {
      return b
        ..isInitializing = store.state.isInitializing
        ..isLoading = store.state.isLoading
        ..currentUser = store.state.currentUser?.toBuilder()
        ..errorMessage = store.state.errorMessage
        ..successMessage = store.state.successMessage
        ..onMessageCount = store.state.onMessageCount
        ..notificationList = store.state.notificationList?.toBuilder()
        ..pagination = store.state.pagination?.toBuilder()
        ..notificationListAction = (int pageNo) {
          store.dispatch(NotificationList(pageNo: pageNo));
        }
        ..updateNotificationReadStatus = (int notificationID) {
          store.dispatch(
              UpdateNotificationReadStatus(notificationID: notificationID));
        };
    });
  }

  NotificationListAction get notificationListAction;

  UpdateNotificationReadStatusAction get updateNotificationReadStatus;


  AppUser? get currentUser;

  bool get isInitializing;

  bool get isLoading;

  String? get errorMessage;

  String? get successMessage;

  BuiltList<Notifications>? get notificationList;

  int? get onMessageCount;

  Pagination? get pagination;
}

class NotificationConnector extends StatelessWidget {
  const NotificationConnector({required this.builder});

  final ViewModelBuilder<NotificationModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NotificationModel>(
      builder: builder,
      converter: (Store<AppState> store) => NotificationModel.fromStore(store),
    );
  }
}
