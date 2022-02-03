import 'package:personal_pjt/models/models.dart';
import 'package:personal_pjt/reducers/auth/auth_reducer.dart';
import 'package:personal_pjt/reducers/notification/notification_reducer.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  authReducer,
  notificationReducer
]);
