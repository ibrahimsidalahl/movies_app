import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/core/funcation/funcation.dart';
import 'package:movies_app/core/styles/app_style.dart';
import 'package:movies_app/core/widgets/custom_text_button.dart';
import 'package:movies_app/core/widgets/custom_text_container.dart';
import 'package:movies_app/features/auth/login/presentation/screens/sign_in_screen.dart';
import 'package:movies_app/features/profile/presentation/manger/theme_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  File? imageFile;
  String? url;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    imageFile = File(image.path);
    final storageRef = FirebaseStorage.instance.ref().child('profile_images/${basename(image.path)}');

    try {
      final uploadTask = storageRef.putFile(imageFile!);
      await uploadTask;

      final downloadUrl = await storageRef.getDownloadURL();
      setState(() {
        url = downloadUrl;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text('Your Profile', style: AppStyles.colorPageTitle(context)),
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  navigate(context: context, screen: SignInScreen());
                },
                icon: Icon(
                  Icons.output,
                  color: Color(0xffEB5757),
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30.w),
                      InkWell(
                        onDoubleTap: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.noHeader,
                            animType: AnimType.rightSlide,
                            title: 'Upload Your photo',
                            btnOkText: 'Upload',
                            btnOkOnPress: () {
                              getImage();
                            },
                            btnOkColor: Color(0xffEB5757),
                          )..show();
                        },
                        child: CircleAvatar(
                          radius: 80.r,
                          backgroundColor: Color(0xffEB9E9E),
                          backgroundImage: url != null && url!.isNotEmpty
                              ? NetworkImage(url!)
                              : AssetImage('assets/profile.png') as ImageProvider,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        '${userData['name']}',
                        style: AppStyles.style16(context),
                      ),
                      SizedBox(height: 20.h),
                      CustomTextContainer(
                        leading: Icon(
                          Icons.email_sharp,
                          size: 24.sp,
                          color: Color(0xffEB5757),
                        ),
                        title: Text(
                          'Your Email :',
                          style: AppStyles.style16(context),
                        ),
                        subTitle: Text(
                          '${currentUser.email}',
                          style: AppStyles.stylee16(context),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Divider(),
                      SizedBox(height: 20.h),
                      CustomTextContainer(
                        leading: Icon(
                          Icons.phone_android,
                          size: 24.sp,
                          color: Color(0xffEB5757),
                        ),
                        title: Text(
                          'Your Phone :',
                          style: AppStyles.style16(context),
                        ),
                        subTitle: Text(
                          '${userData['phone']}',
                          style: AppStyles.stylee16(context),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Container(
                        width: 200.w,
                        child: CustomTextButton(
                          title: 'Switch Mode',
                          onPressed: () {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleMode();
                          },
                        ),
                      ),
                      SizedBox(height: 30.h,)
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
