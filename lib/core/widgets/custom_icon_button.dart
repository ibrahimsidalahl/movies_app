import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget{
  final IconData icon ;
  final Color? color;
  final void Function()? onPressed ;

  const CustomIconButton({super.key,
    required this.onPressed,
    required this.icon,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,color:Color(0xffEB5757),
        size: 28.sp,
      ),
      onPressed: onPressed,
      color: color,
    );
  }
}