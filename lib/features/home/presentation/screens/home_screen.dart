import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/funcation/funcation.dart';
import 'package:movies_app/core/http_services/http_services.dart';
import 'package:movies_app/core/styles/app_style.dart';
import 'package:movies_app/core/widgets/custom_icon_button.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:movies_app/features/home/presentation/screens/movie_details_screen.dart';
import 'package:movies_app/features/home/presentation/screens/search_delegate.dart';
import 'package:provider/provider.dart';

import '../../../favorite/presentation/manger/favorite_movie_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Provider.of<FavoriteMovieProvider>(context, listen: false)
            .fetchFavoriteMovie();
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                Search();
              },
              icon: Icon(
                Icons.search,
                color: Color(0xffEB5757),
              ))
        ],
        title: Text('Trending', style: AppStyles.colorPageTitle(context)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder<List<MoviesModel>>(
        future: HttpServices.getMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 6.h,
                  mainAxisSpacing: 2.w),
              itemBuilder: (context, index) {
                List<MoviesModel> movies = snapshot.data!;
                final movie = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(navigate(
                        context: context,
                        screen: MovieDetailsScreen(movie: movie)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      children: [
                        Stack(children: [
                          Hero(
                            tag: Container,
                            child: Container(
                              height: 209.h,
                              width: 180.w,
                              decoration: BoxDecoration(
                                //color: Colors.w,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(movies[index].image!),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 160.h,
                            left: 120.w,
                            child: CustomIconButton(
                              icon:  Provider.of<FavoriteMovieProvider>(context).isFavoriteMovie('${movies[index].id}') ? Icons.favorite : Icons.favorite_border_rounded,
                              onPressed: () async {
                                FavoriteMovieProvider favoriteMovieProvider =
                                    Provider.of<FavoriteMovieProvider>(context,
                                        listen: false);
                                if (favoriteMovieProvider
                                    .isFavoriteMovie('${movies[index].id}')) {
                                  favoriteMovieProvider.removeFavoriteMovie(
                                      '${movies[index].id}');
                                } else {
                                  favoriteMovieProvider.addFavoriteMovie(
                                    '${movies[index].id}',
                                    '${movies[index].title}',
                                    '${movies[index].image}',
                                  );
                                }
                              },
                            ),

                            // child: IconButton(
                            //   icon: (
                            //       FavoriteMovieProvider().isFavoriteMovie('${movies[index].id}'))
                            //       ?  Icon(Icons.favorite,
                            //     size: 28.sp,
                            //     color: Color(0xffEB5757),)
                            //       :  Icon(Icons.favorite_border, size: 28.sp,color: Color(0xffEB5757),),
                            //   onPressed: () async {
                            //     Provider.of<FavoriteMovieProvider>(context,
                            //         listen: false)
                            //         .addFavoriteMovie(
                            //       '${movies[index].id}',
                            //       '${movies[index].title}',
                            //       '${movies[index].image}',
                            //     );
                            //   },
                            // ),
                          )
                        ]),
                        Text(movies[index].title!,
                            style: AppStyles.colorMovieTitle(context)),
                        Row(
                          children: [
                            Text(
                              movies[index].rating!,
                              style: AppStyles.style14(context),
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0xffEB5757),
                              size: 18.sp,
                            ),
                            SizedBox(
                              width: 80.w,
                            ),
                            Text(
                              '(${movies[index].year})',
                              style: AppStyles.style14(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
