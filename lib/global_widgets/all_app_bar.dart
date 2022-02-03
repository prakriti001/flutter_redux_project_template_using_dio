// import 'package:personal_pjt/global_widgets/dart_helper.dart';
// import 'package:personal_pjt/global_widgets/padding_helper.dart';
// import 'package:personal_pjt/global_widgets/text_helper.dart';
// import 'package:personal_pjt/global_widgets/widget_helper.dart';
// import 'package:flutter/material.dart';
//
// class AllAppBar extends StatelessWidget {
//   const AllAppBar(
//       {Key? key,
//       required this.title,
//       required this.tabBarTitle,
//       this.showBellIcon = false,
//       required this.color})
//       : super(key: key);
//   final bool tabBarTitle;
//   final String title;
//   final bool showBellIcon;
//   final String color;
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationConnector(
//         builder: (BuildContext context, NotificationModel notificationModel) {
//       return SliverPersistentHeader(
//         delegate: Delegate(tabBarTitle, title, showBellIcon, notificationModel,
//             fromLoanApplication, currentStep, color, totalStep),
//         pinned: true,
//       );
//     });
//   }
// }
//
// class Delegate extends SliverPersistentHeaderDelegate {
//   final bool tabBarTitle;
//   final String _title;
//   final bool showBellIcon;
//   final NotificationModel notificationModel;
//   final bool fromLoanApplication;
//   final int currentStep;
//   final int totalStep;
//   final String color;
//
//   Delegate(
//       this.tabBarTitle,
//       this._title,
//       this.showBellIcon,
//       this.notificationModel,
//       this.fromLoanApplication,
//       this.currentStep,
//       this.color,
//       this.totalStep);
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     final bellIcon = Stack(
//       children: [
//         IconButton(
//             onPressed: () {
//               notificationModel.notificationListAction(1);
//               Navigator.pushNamed(context, '/notification');
//             },
//             icon: Icon(MyFlutterApp.notification, color: Colors.white)),
//         Positioned(
//           right: 15.0,
//           top: 8.0,
//           child: ((DartHelper.isNullOrEmpty(notificationModel
//                       ?.pagination?.unreadCount
//                       ?.toString())) &&
//                   notificationModel.onMessageCount == 0)
//               ? emptyBox()
//               : Container(
//                   padding: const EdgeInsets.all(6.0),
//                   decoration: const BoxDecoration(
//                       shape: BoxShape.circle, color: Colors.white),
//                 ),
//         )
//       ],
//     );
//
//     final accessDeligateButton = IconButton(
//         onPressed: () {
//           Utils.showModelSheet(context, BADeligateAcccessModelSheet());
//         },
//         icon: Icon(FontAwesomeIcons.universalAccess, color: Colors.white));
//
//     var withBellIcon = Row(
//       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         appBarText(_title ?? ''),
//         Spacer(),
//         _title == 'Product Requests' ? accessDeligateButton : emptyBox(),
//         showBellIcon ? bellIcon : emptyBox()
//       ],
//     );
//
//     final stepText = Padding(
//         padding: PaddingHelper.fromOnly(0.0, 0.0, 10.0, 0.0),
//         child: Text(
//           'step ${currentStep?.toString()} of ${totalStep?.toString()}',
//           style: AppStyle.grey14RegularTextStyle
//               .copyWith(color: AppColors.yellowColor),
//           softWrap: true,
//         ));
//
//     final withIcon = Row(
//       children: [
//         backIcon(context),
//         Expanded(
//             flex: 3,
//             child: fromLoanApplication
//                 ? loanAppBarText(_title ?? '')
//                 : appBarText(_title ?? '')),
//         fromLoanApplication
//             ? stepText
//             : showBellIcon
//                 ? bellIcon
//                 : emptyBox()
//       ],
//     );
//
//     return Container(
//         decoration: BoxDecoration(
//             gradient: DartHelper.isNullOrEmpty(color)
//                 ? AppGradients.basicGradient
//                 : AppGradients.coloredGradient(color)),
//         alignment: Alignment.centerLeft,
//         padding:
//             PaddingHelper.fromOnly(tabBarTitle ? 20.0 : 5.0, 0.0, 0.0, 0.0),
//         child: tabBarTitle ? withBellIcon : withIcon);
//   }
//
//   @override
//   double get maxExtent => 90;
//
//   @override
//   double get minExtent => 60;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }
