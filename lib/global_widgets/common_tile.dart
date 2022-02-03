// import 'package:finnobuddy_customer/core/theme/app_colors.dart';
// import 'package:finnobuddy_customer/global_widgets/padding_helper.dart';
// import 'package:finnobuddy_customer/global_widgets/widget_helper.dart';
// import 'package:flutter/material.dart';
//
// class CommonTile extends StatelessWidget {
//   final Widget child;
//   final EdgeInsets padding;
//   final EdgeInsets margin;
//
//   const CommonTile({Key key, this.child, this.padding, this.margin})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:
//           padding == null ? PaddingHelper.fromSymmetric(15.0, 25.0) : padding,
//       margin: margin == null ? PaddingHelper.fromSymmetric(15.0, 10.0) : margin,
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
//   }
// }
