import 'package:built_collection/built_collection.dart';
import 'package:personal_pjt/models/models.dart';

//*************************** list-notifications ******************************//
class NotificationList {
  final int? pageNo;

  NotificationList({this.pageNo});
}

//*********************** save-notifications-list *****************************//
class SaveNotificationList {
  SaveNotificationList({this.notificationList});

  final BuiltList<Notifications>? notificationList;
}

//***************************** save-onMessage-state **************************//
class SaveOnMessageCount {
  SaveOnMessageCount({required this.onMessageCount});

  final int onMessageCount;
}

//************************** save-pagination-data-in-state ********************//
class SaveNotificationPagination {
  SaveNotificationPagination({this.pagination});

  final Pagination? pagination;
}

//************************** update-read-status-notification ******************//
class UpdateNotificationReadStatus {
  UpdateNotificationReadStatus({this.notificationID});

  final int? notificationID;
}
