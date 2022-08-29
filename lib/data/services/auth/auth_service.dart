import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:personal_pjt/data/api/api_client.dart';
import 'package:personal_pjt/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:personal_pjt/models/models.dart';
import 'package:personal_pjt/models/serializers.dart';

class AuthService extends ApiService {
  AuthService({required ApiClient client}) : super(client: client);

//************************************ log-in *********************************//
  Future<Map<String, dynamic>?> loginWithPassword(
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
      }
      else{
        throw true;
      }
  }

  Future<AppUser?> getUserDetails(
      {Map<String, String>? headers, int? userID,Map<String, dynamic>? body,List<String>? fileNames,
        List<String>? filePath}) async {
      final ApiResponse<ApiSuccess> res = await client!.callJsonApi<ApiSuccess>(
          method: Method.PUT,
          formDataRequest: true,
          fileNames: fileNames,
          filePath: filePath,
          body: body,
          path: '/user_management/business/businesses/update_profile',
          headers: headers);
      if (res.isSuccess) {
        return res.resData!.user;
      }
      else{
        throw true;
      }
  }
}
