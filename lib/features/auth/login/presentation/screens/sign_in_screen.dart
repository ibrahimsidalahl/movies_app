import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/funcation/funcation.dart';
import 'package:movies_app/features/auth/register/presentation/screens/register_screen.dart';
import 'package:movies_app/features/curved_navigation_bar/presentation/screens/curved_navigation_bar.dart';

import '../../../../../core/styles/app_style.dart';
import '../../../../../core/widgets/custom_circle_avatar.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../../../core/widgets/custom_text_form_filed.dart';
import '../../../../home/presentation/screens/home_screen.dart';

class SignInScreen extends StatelessWidget {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  SignInScreen({super.key});

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
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: AppStyles.style32(context),
                    ),
                    Text(
                      'Hi! Welcome back, You\'ve been mised',
                      style: AppStyles.style18,
                    ),
                  ],
                )),
                Image.asset('assets/logo.png',fit: BoxFit.fill,height: 150.h,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                          style: AppStyles.style24(context)                      ),
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
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        'Password',
                          style: AppStyles.style24(context)                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forget Password ?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16.sp,
                                  color: Color(0xffEB5757),
                                ),
                              )),
                        ],
                      ),
                      CustomTextButton(
                          title: 'Sign In',
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                emailController.clear();
                                passwordController.clear();
                                navigate(
                                    context: context,
                                    screen: CurvedNavigatonBarScreen());
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print(e);

                                } else if (e.code == 'wrong-password') {
                                  print('$e');
                                }
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text('Or sign in with',style: AppStyles.text16(context),),
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
                          Text(
                            'Don\'t have an account ?',
                            style: AppStyles.label18(context)
                          ),
                          TextButton(
                              onPressed: () {
                                navigate(
                                    context: context, screen: RegisterScreen());
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18.sp,
                                  color: Color(0xffEB5757),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
