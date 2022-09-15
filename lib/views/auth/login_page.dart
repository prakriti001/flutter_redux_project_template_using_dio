import 'package:image_picker/image_picker.dart';
import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:personal_pjt/connector/auth_connector.dart';

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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  XFile? image;
  @override
  Widget build(BuildContext context) {
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
                                                      path: 'staging/0d140fa3-3ed3-429d-b919-52b4340d995f/image_cropper_1662016523104.jpg',
                                                    );
                                                  }),
                                                ])))
                                  ])))
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
