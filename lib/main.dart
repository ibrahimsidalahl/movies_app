import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/sqflite_services/sqflite_services.dart';
import 'package:movies_app/features/curved_navigation_bar/presentation/manger/navigation_provider.dart';
import 'package:movies_app/features/curved_navigation_bar/presentation/screens/curved_navigation_bar.dart';
import 'package:movies_app/features/favorite/presentation/manger/favorite_movie_provider.dart';
import 'package:movies_app/features/home/presentation/manger/movies_provider.dart';
import 'package:movies_app/features/home/presentation/screens/home_screen.dart';
import 'package:movies_app/features/profile/presentation/presentation/manger/theme_provider.dart';
import 'package:movies_app/features/splash/prsentation/screens/splash_screen.dart';
import 'package:movies_app/firebase_options.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteServices().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MoviesProvider()),
      ChangeNotifierProvider(create: (context) => FavoriteMovieProvider()),
      ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child:MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: Provider.of<ThemeProvider>(context).getCurrentTheme(),
                home:SplashView()
          );

        });
  }
}
