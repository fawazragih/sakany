import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconTemplate extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Function({required String? urlLink})? onTap;
  final bool isSmallIcon;
  final String? data;

  const IconTemplate(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.backgroundColor,
      this.isSmallIcon = false,
      this.onTap,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          isSmallIcon ? 6.0 : 10.0,
        ),
        color: backgroundColor,
      ),
      padding: EdgeInsets.all(isSmallIcon ? 3.0 : 10.0),
      child: InkWell(
        onTap: () async {
          if (onTap != null) onTap!(urlLink: data);
        },
        child: Icon(
          icon,
          color: iconColor,
          size: isSmallIcon ? 18.sp : null,
        ),
      ),
    );
  }
}
