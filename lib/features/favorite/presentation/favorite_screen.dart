import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/styles/app_style.dart';
import 'package:movies_app/features/favorite/presentation/manger/favorite_movie_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/sqflite_services/sqflite_services.dart';
import '../../home/data/models/movies_model.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override


  Widget build(BuildContext context) {
    final favoriteProduct = Provider.of<FavoriteMovieProvider>(context).favoriteMovie;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Favorite', style: AppStyles.colorPageTitle(context)),
      ),
      body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
              itemCount: favoriteProduct!.length,

        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            width: 182.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 205.h,
                      width: 182.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(favoriteProduct[index]['image']),
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    Positioned(
                      bottom: 160.h,
                      left: 120.w,
                      child: IconButton(
                        onPressed: () async {
                          await Provider.of<FavoriteMovieProvider>(context, listen: false)
                              .removeFavoriteMovie(favoriteProduct[index]['id']);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Color(0xffEB5757),
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  favoriteProduct[index]['title'],
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.colorMovieTitle(context),
                ),
              ],
            ),
          );
        },

      )

    );
  }
}
