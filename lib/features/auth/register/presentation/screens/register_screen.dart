import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/funcation/funcation.dart';
import 'package:movies_app/core/styles/app_style.dart';
import 'package:movies_app/core/widgets/custom_circle_avatar.dart';
import 'package:movies_app/core/widgets/custom_text_form_filed.dart';
import 'package:movies_app/features/auth/login/presentation/screens/sign_in_screen.dart';
import 'package:movies_app/features/curved_navigation_bar/presentation/screens/curved_navigation_bar.dart';

import '../../../../../core/widgets/custom_text_button.dart';

class RegisterScreen extends StatelessWidget {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmPasswordController =
      TextEditingController();

  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Create Acount',
                      style: AppStyles.style32(context),
                    ),
                    Text(
                      'Fill your information below or register with your social account',
                      style: AppStyles.style18,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
                Text('Name', style: AppStyles.style24(context)),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    Icons.person,
                    size: 20.sp,
                    color: Color(0xffEB5757),
                  ),
                  title: 'Enter your name',
                  controller: nameController,
                  obscureText: false,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text('Email', style: AppStyles.style24(context)),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    size: 20.sp,
                    color: Color(0xffEB5757),
                  ),
                  title: 'Enter your email',
                  controller: emailController,
                  obscureText: false,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text('phone', style: AppStyles.style24(context)),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(
                    Icons.phone_android,
                    size: 20.sp,
                    color: Color(0xffEB5757),
                  ),
                  title: 'Enter your phone number',
                  controller: phoneController,
                  obscureText: false,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text('Password', style: AppStyles.style24(context)),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    Icons.password,
                    size: 20.sp,
                    color: Color(0xffEB5757),
                  ),
                  isPassword: true,
                  isSuffixIconShown: true,
                  title: 'Enter your password',
                  controller: passwordController,
                  obscureText: false,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text('Confirm Password', style: AppStyles.style24(context)),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your confirm password';
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    Icons.password,
                    size: 20.sp,
                    color: Color(0xffEB5757),
                  ),
                  isPassword: true,
                  isSuffixIconShown: true,
                  title: 'Enter your confirm password',
                  controller: confirmPasswordController,
                  obscureText: false,
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextButton(
                    title: 'Sign Up',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final UserCredential userCredential =
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(userCredential.user!.email)
                              .set({
                            'name': nameController.text,
                            'phone': phoneController.text,
                          });
                          nameController.clear();
                          emailController.clear();
                          phoneController.clear();
                          passwordController.clear();
                          confirmPasswordController.clear();

                          navigate(
                              context: context,
                              screen: CurvedNavigatonBarScreen());
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: '${e.code}',
                              btnOkOnPress: () {},
                              btnOkColor: Color(0xff704f38),
                            )..show();
                          } else {
                            print('An unexpected error occurred: $e');
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    }),
                Padding(
                  padding: EdgeInsets.all(24.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text('Or sign up with',
                            style: AppStyles.text16(context)),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomCircleAvatar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account ?',
                        style: AppStyles.label18(context)),
                    TextButton(
                        onPressed: () {
                          navigate(context: context, screen: SignInScreen());
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18.sp,
                            color: Color(0xffEB5757),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
