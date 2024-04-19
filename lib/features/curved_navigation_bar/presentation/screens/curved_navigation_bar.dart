import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/styles/app_style.dart';
import 'package:movies_app/features/favorite/presentation/favorite_screen.dart';
import 'package:movies_app/features/home/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme.dart';
import '../../../profile/presentation/presentation/screens/profile_screen.dart';
import '../manger/navigation_provider.dart';

class CurvedNavigatonBarScreen extends StatefulWidget {
  CurvedNavigatonBarScreen({Key? key}) : super(key: key);

  @override
  State<CurvedNavigatonBarScreen> createState() =>
      _CurvedNavigatonBarScreenState();
}

class _CurvedNavigatonBarScreenState extends State<CurvedNavigatonBarScreen> {


  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> _screens = <Widget>[
    // Define the screens here
    HomeScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[Provider.of<NavigationProvider>(context).currentPageIndex], // Use _page to select the appropriate screen
      bottomNavigationBar: CurvedNavigationBar(
        height: 60.h,
        backgroundColor: Color(0xffEB5757),
        key: _bottomNavigationKey,
        animationCurve: Easing.legacyDecelerate,
        animationDuration: Duration(seconds: 1),
        color: Theme.of(context).scaffoldBackgroundColor,
        items: [
          CurvedNavigationBarItem(
            child: Icon(
              Icons.home_outlined,
              color: Theme.of(context).iconTheme.color,
              size: 24.sp,
            ),
            label: 'Home',
            labelStyle: AppStyles.style6(context),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.favorite_border_rounded,
              color: Theme.of(context).iconTheme.color,
              size: 24.sp,
            ),
            label: 'Favorite',
            labelStyle: AppStyles.style6(context),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.perm_identity,
              color: Theme.of(context).iconTheme.color,
              size: 24.sp,
            ),
            label: 'profile',
            labelStyle: AppStyles.style6(context),
          ),
        ],
        onTap: (index) {
          Provider.of<NavigationProvider>(context, listen: false)
              .setCurrentPageIndex(index);
        },
      ),
    );
  }
}
