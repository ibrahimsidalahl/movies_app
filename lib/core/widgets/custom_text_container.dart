import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/profile/presentation/presentation/screens/profile_screen.dart';

class CustomTextContainer extends StatelessWidget {
  Widget title;
  Widget subTitle;
  Widget leading;

  CustomTextContainer(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(16.r)),
      child: ListTile(
        title: title,
        leading: leading,
        subtitle: subTitle,

      ),
    );
  }
}
