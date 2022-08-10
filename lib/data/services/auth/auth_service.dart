import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:personal_pjt/data/api/api_client.dart';
import 'package:personal_pjt/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:personal_pjt/models/models.dart';
import 'package:personal_pjt/models/serializers.dart';

class AuthService extends ApiService {
  AuthService({required ApiClient client}) : super(client: client);

//************************************ log-in *********************************//
  Future<Map<String, dynamic>> loginWithPassword(
      {Map<String, dynamic>? objToApi}) async {
    final ApiResponse<ApiSuccess> res = await client!.callJsonApi<ApiSuccess>(
        method: Method.POST,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        path: '/auth_management/user/auth/login',
        body: objToApi);
    if (res.isSuccess) {
      return {'user': res.resData!.user};
    } else {
      throw res.error.error;
    }
  }
  Future<AppUser?> getUserDetails(
      {Map<String, String>? headers, int? userID}) async {
    final ApiResponse<ApiSuccess> res = await client!.callJsonApi<ApiSuccess>(
        method: Method.GET,
        path: '/user_management/business/businesses/get_profile',
        headers: headers);
    if (res.isSuccess) {
      return res.resData!.user;
    } else if (res.isUnAuthorizedRequest) {
      throw true;
    } else {
      throw res.error;
    }
  }

}
