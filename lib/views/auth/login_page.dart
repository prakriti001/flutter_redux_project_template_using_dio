import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:personal_pjt/connector/auth_connector.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: 'sampleuser@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'samplepassword');
  final Hero logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Text('qw12'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AuthConnector(
      builder: (BuildContext c, AuthViewModel model) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.65),
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      AppColors.themeColor.withOpacity(0.6),
                      BlendMode.dstATop),
                  child: Text('qkjwbc'),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      print("===========qwkljdc");
                      //model.loginWithPassword('', 'wekdc', 'qkwjbec');
                      model.getUserDetailsAction();
                    },
                    child: Text(
                      'qwjhvchkwvcdq',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
