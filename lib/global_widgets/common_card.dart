// import 'package:finnobuddy_customer/core/theme/app_colors.dart';
// import 'package:finnobuddy_customer/global_widgets/padding_helper.dart';
// import 'package:finnobuddy_customer/global_widgets/widget_helper.dart';
// import 'package:flutter/material.dart';
//
// class CommonCard extends StatelessWidget {
//   const CommonCard({Key key, this.child, this.login = true, this.height = 15.0})
//       : super(key: key);
//   final Widget child;
//   final bool login;
//   final double height;
//
//   @override
//   Widget build(BuildContext context) {
//     final card = Card(
//       shape: RoundedRectangleBorder(borderRadius: border(8.0)),
//       elevation: 4,
//       child: child,
//     );
//
//     final container = Container(
//       margin: PaddingHelper.fromSymmetric(15.0, height),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: border(8.0),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.textFieldTitleColor.withOpacity(0.8),
//               blurRadius: 5.0,
//               spreadRadius: 2.0,
//             ),
//           ]),
//       child: child,
//     );
//     return login ? card : container;
//   }
// }
