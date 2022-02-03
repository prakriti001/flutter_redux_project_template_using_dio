import 'package:personal_pjt/actions/actions.dart';
import 'package:personal_pjt/models/app_state.dart';
import 'package:redux/redux.dart';

Reducer<AppState> notificationReducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, SaveNotificationList>(saveNotificationList),
  TypedReducer<AppState, SaveOnMessageCount>(saveOnMessageCount),
  TypedReducer<AppState, SaveNotificationPagination>(
      saveNotificationPagination),
]);

AppState saveNotificationList(AppState state, SaveNotificationList action) {
  final AppStateBuilder b = state.toBuilder();
  b..notificationList = action.notificationList?.toBuilder();
  return b.build();
}

AppState saveOnMessageCount(AppState state, SaveOnMessageCount action) {
  final AppStateBuilder b = state.toBuilder();
  b..onMessageCount = action.onMessageCount;
  return b.build();
}

AppState saveNotificationPagination(
    AppState state, SaveNotificationPagination action) {
  final AppStateBuilder b = state.toBuilder();
  b..pagination = action.pagination?.toBuilder();
  return b.build();
}
