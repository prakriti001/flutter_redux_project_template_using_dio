import 'dart:convert';

import 'package:personal_pjt/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesClient {
  PreferencesClient({required this.prefs});

  final SharedPreferences prefs;

  AppUser? getUser() {
    final String? userString = prefs.getString('appUser');
    if (userString == null) {
      return null;
    }
    final dynamic user = json.decode(userString);
    return serializers.deserializeWith(AppUser.serializer, user);
  }

  void saveUser({AppUser? appUser}) {
    if (appUser == null) {
      prefs.setString('appUser', '');
      return null;
    }
    final dynamic user = serializers.serializeWith(AppUser.serializer, appUser);
    final String userString = json.encode(user);
    prefs.setString('appUser', userString);
  }

  //****************************** user-access-token **************************//
  AccessToken? getUserAccessToken() {
    final String? tokenString = prefs.getString('token');
    if (tokenString == null) {
      return null;
    }
    final dynamic accessToken = json.decode(tokenString);
    return serializers.deserializeWith(AccessToken.serializer, accessToken);
  }

  void setUserAccessToken({AccessToken? token}) {
    if (token == null) {
      prefs.setString('token', '');
      return null;
    }
    final dynamic accessToken =
        serializers.serializeWith(AccessToken.serializer, token);
    final String tokenString = json.encode(accessToken);
    prefs.setString('token', tokenString);
  }
}
