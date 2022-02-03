import 'package:personal_pjt/connector/auth_connector.dart';
import 'package:personal_pjt/views/home/home_page.dart';
import 'package:personal_pjt/views/loader/app_loader.dart';
import 'package:personal_pjt/views/auth/login_page.dart';
import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthConnector(
      builder: (BuildContext c, AuthViewModel model) {
        if (model.isInitializing) {
          return AppLoader();
        }
        return model.currentUser == null ? LoginPage() : HomePage();
      },
    );
  }
}
