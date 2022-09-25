import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:personal_pjt/connector/auth_connector.dart';

import '../../core/theme/app_styles.dart';
import '../../global_widgets/padding_helper.dart';
import '../../global_widgets/widget_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObSecureText = true;
  String version = '1';
  String buildNumber = '0';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  XFile? image;

  @override
  void initState() {
    super.initState();
    getVersionDetails();
  }

  Future<void> getVersionDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final versionText = Padding(
        padding: PaddingHelper.fromSymmetric(10.0, 0.0),
        child: Text('Version $version+$buildNumber',
            style: AppStyle.grey14RegularTextStyle),);
    return AuthConnector(
        builder: (BuildContext c, AuthViewModel authViewModel) {
          return Scaffold(
              body: Stack(children: [
                Container(color: AppColors.themeColor),
                SafeArea(
                    child: Column(children: [
                      Expanded(
                          child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0))),
                              child: ListView(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Form(
                                            key: _formKey,
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  getSpace(40, 0),
                                                  Text('Employee ID',),
                                                  getSpace(10, 0),
                                                  TextFormField(
                                                      controller: _usernameController,
                                                      textInputAction: TextInputAction.next,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Enter employee id to continue';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: const InputDecoration(
                                                          hintText: 'Employee ID')),
                                                  getSpace(20, 0),
                                                  Text('Password'),
                                                  getSpace(10, 0),
                                                  TextFormField(
                                                      obscureText: isObSecureText,
                                                      controller: _passwordController,
                                                      textInputAction: TextInputAction.done,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Enter password to continue';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                          hintText: 'Password',
                                                          suffixIcon: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  isObSecureText =
                                                                  !isObSecureText;
                                                                });
                                                              },
                                                              child: Icon(
                                                                  isObSecureText
                                                                      ? Icons
                                                                      .remove_red_eye_outlined
                                                                      : Icons
                                                                      .remove_red_eye,
                                                                  color: AppColors
                                                                      .themeColor)))),
                                                  getSpace(40, 0),
                                                  submitButton('LOGIN', () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      authViewModel.loginWithPassword('',
                                                          _usernameController.text
                                                              .trim(),
                                                          _passwordController.text
                                                              .trim());
                                                    }
                                                      }),
                                                  submitButton('PICK IMAGE', () async{
                                                     image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                  }),
                                                  submitButton('UPLOAD', () async{
                                                    authViewModel.getUserDetailsAction(
                                                      s3BucketKey: 'staging/a4ee6ae7-2e61-486d-bcb5-4e82c4a5305c/image_picker4090513709980994010.jpg',
                                                    );
                                                  }),
                                                  submitButton('UPLOAD TO S3', () async{
                                                    authViewModel.uploadFileAction(
                                                        image?.path.split('/').last,
                                                        File(image!.path),
                                                            (String? url){
                                                          print('urllllll : ${url}');
                                                        }
                                                    );
                                                  }),
                                                ])))
                                  ]))),
                      versionText
                    ])),
                // globalLoader(authViewModel.isLoading)
              ]));
        });
  }
}

// class LoginPage extends StatelessWidget {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController =
//       TextEditingController(text: 'sampleuser@gmail.com');
//   final TextEditingController _passwordController =
//       TextEditingController(text: 'samplepassword');
//   final Hero logo = Hero(
//     tag: 'hero',
//     child: CircleAvatar(
//       backgroundColor: Colors.transparent,
//       radius: 48.0,
//       child: Text('qw12'),
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return AuthConnector(
//       builder: (BuildContext c, AuthViewModel model) {
//         return Scaffold(
//           body: SafeArea(
//             child: Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: AppColors.themeColor.withOpacity(0.65),
//                   ),
//                   child: ColorFiltered(
//                     colorFilter: ColorFilter.mode(
//                         AppColors.themeColor.withOpacity(0.6),
//                         BlendMode.dstATop),
//                     child: Text('qkjwbc'),
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         print("===========qwkljdc");
//                         model.loginWithPassword('', 'wekdc', 'qkwjbec');
//                       },
//                       child: Text(
//                         'qwjhvchkwvcdq',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
