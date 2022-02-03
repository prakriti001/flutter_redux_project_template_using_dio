// import 'package:finnobuddy_customer/global_widgets/toast_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:personal_pjt/global_widgets/toast_helper.dart';
//
// class GlobalErrorAlert extends StatelessWidget {
//   const GlobalErrorAlert({Key key, this.text, this.onTap}) : super(key: key);
//   final String text;
//   final Function onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: ToastHelper.getToast(
//             text,
//             MediaQuery.of(context).size.height - 110,
//             onTap == null ? () => Navigator.pop(context) : onTap),
//       ),
//     );
//   }
// }
