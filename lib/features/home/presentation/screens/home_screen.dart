import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/funcation/funcation.dart';
import 'package:movies_app/core/styles/app_style.dart';
import 'package:movies_app/core/widgets/custom_icon_button.dart';
import 'package:movies_app/features/home/presentation/manger/movies_provider.dart';
import 'package:movies_app/features/home/presentation/screens/movie_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        Provider.of<MoviesProvider>(context, listen: false).fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = context.watch<MoviesProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Color(0xffEB5757),
              ))
        ],
        title: Text('Trending', style: AppStyles.colorPageTitle(context)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: moviesProvider.movies != null
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 6.h,
                mainAxisSpacing: 2.w,
              ),
              itemCount: moviesProvider.movies!.length,
              itemBuilder: (context, index) {
                final movie = moviesProvider.movies![index];
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
                        Stack(
                          children: [
                            Hero(
                              tag: movie.id!,
                              child: Container(
                                height: 220.h,
                                width: 180.w,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: movie.image!,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 160.h,
                              left: 120.w,
                              child: CustomIconButton(
                                icon:
                                    Provider.of<FavoriteMovieProvider>(context)
                                            .isFavoriteMovie(movie.id!)
                                        ? Icons.favorite
                                        : Icons.favorite_border_rounded,
                                onPressed: () async {
                                  FavoriteMovieProvider favoriteMovieProvider =
                                      Provider.of<FavoriteMovieProvider>(
                                          context,
                                          listen: false);
                                  if (favoriteMovieProvider
                                      .isFavoriteMovie(movie.id!)) {
                                    favoriteMovieProvider
                                        .removeFavoriteMovie(movie.id!);
                                  } else {
                                    favoriteMovieProvider.addFavoriteMovie(
                                      movie.id!,
                                      movie.title!,
                                      movie.image!,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          movie.title!,
                          style: AppStyles.colorMovieTitle(context),
                        ),
                        Row(
                          children: [
                            Text(
                              movie.rating!,
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
                              '(${movie.year})',
                              style: AppStyles.style14(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
