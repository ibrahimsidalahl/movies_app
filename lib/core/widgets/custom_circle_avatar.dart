
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/core/funcation/funcation.dart';
import 'package:movies_app/features/home/presentation/screens/home_screen.dart';


class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({Key? key});

  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    navigate(context: context, screen: HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          signInWithGoogle(context);
        },
        child: CircleAvatar(
          maxRadius: 32.r,
          backgroundColor: Colors.grey[200],
          child: Image.asset(
            'assets/img.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
