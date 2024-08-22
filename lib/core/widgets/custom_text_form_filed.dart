import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/widgets/custom_icon_button.dart';

class CustomTextFormField extends StatefulWidget {
  final String title;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  bool isPassword;
  final bool isSuffixIconShown;

  CustomTextFormField({
    super.key,
    required this.title,
    this.keyboardType,
    required this.validator,
    required this.controller,
    required this.prefixIcon,
    this.isPassword = false,
    this.isSuffixIconShown = false,
    required this.obscureText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 18.sp,
      ),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPassword,
      decoration: InputDecoration(


        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isSuffixIconShown
            ? CustomIconButton(
          onPressed: () {
            setState(() {
              widget.isPassword = !widget.isPassword;
            });
          },
          icon: widget.isPassword
              ? Icons.visibility_off_outlined
              : Icons.remove_red_eye_outlined,
        )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.r)),
          borderSide: BorderSide(
            color: Color(0xffEB5757),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffEB5757),
          ),
          // borderRadius: BorderRadius.all(Radius.circular(24.r)),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 8.h,
        ),
        hintText: widget.title,
        hintStyle: TextStyle(
          color: Colors.grey[700],
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
