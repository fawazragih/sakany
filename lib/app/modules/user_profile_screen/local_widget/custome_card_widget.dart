// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CustomCard extends StatelessWidget {
//   final Color cardColour;
//   final IconData cardLeading;
//   final String cardTitle;
//   final String cardSubtitle;
//   final Widget trailingCard;
//   final Function onPress;
//   final bool showBadge;
//   final double borderRadius;
//   final double elevation;
//   final Color leadingBGColor;
//   final Color titleColor;
//
//   CustomCard({
//     Key key,
//     this.cardColour,
//     this.cardLeading,
//     this.cardTitle,
//     this.cardSubtitle,
//     this.trailingCard,
//     this.onPress,
//     this.borderRadius = 8.0,
//     this.elevation,
//     this.showBadge = false,
//     this.leadingBGColor,
//     this.titleColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return RawMaterialButton(
//       fillColor: cardColour ?? Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(borderRadius),
//       ),
//       elevation: elevation ?? 1,
//       child: ListTile(
//         // dense: true,
//         contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
//         leading: CircleAvatar(
//           backgroundColor: leadingBGColor ?? Get.theme.primaryColor,
//           child: showBadge
//               ? Badge(
//                   child: Icon(
//                     cardLeading,
//                     color: Colors.white,
//                   ),
//                 )
//               : Icon(
//                   cardLeading,
//                   color: Colors.white,
//                 ),
//         ),
//         title: AutoSizeText(
//           cardTitle.tr.capitalizeFirst,
//           style: Get.textTheme.subtitle2.copyWith(
//             color: titleColor,
//           ),
//         ),
//         subtitle: cardSubtitle != null
//             ? AutoSizeText(cardSubtitle.tr.capitalizeFirst)
//             : null,
//         trailing: trailingCard,
//       ),
//       onPressed: onPress,
//     );
//   }
// }
