import 'package:personal_pjt/data/api/api_client.dart';
import 'package:personal_pjt/data/services/api_service.dart';
import 'package:personal_pjt/models/models.dart';

class NotificationService extends ApiService {
  NotificationService({required ApiClient client}) : super(client: client);

//**************************** get-notification-lists *************************//
  Future<Map<String, Object>> getNotificationsList(
      {int? pageNo, Map<String, String>? headersToApi}) async {
    final Map<String, String> queryParams = <String, String>{
      'page': pageNo.toString()
    };
    final ApiResponse<ApiSuccess> res = await client!.callJsonApi<ApiSuccess>(
      method: Method.GET,
      headers: headersToApi,
      queryParams: queryParams,
      path: '/notification_management/customer/notifications',
    );
    if (res.isSuccess) {
      return {
        'notifications': res.data!.notifications,
        'meta': res.data!.meta!
      };
    } else if (res.isUnAuthorizedRequest) {
      throw true;
    } else {
      throw res.error;
    }
  }

//************************** update-read-status-notification *******************//
  Future<Notifications> updateNotificationReadStatus(
      {int? notificationID, Map<String, String>? headersToApi}) async {
    final ApiResponse<ApiSuccess> res = await client!.callJsonApi<ApiSuccess>(
      method: Method.PUT,
      headers: headersToApi,
      path: '/notification_management/customer/notifications',
    );
    if (res.isSuccess) {
      return res.data!.notification!;
    } else if (res.isUnAuthorizedRequest) {
      throw true;
    } else {
      throw res.error;
    }
  }
}
