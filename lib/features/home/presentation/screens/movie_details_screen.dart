import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/funcation/funcation.dart';
import 'package:movies_app/core/http_services/http_services.dart';
import 'package:movies_app/core/widgets/custom_icon_button.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:movies_app/features/curved_navigation_bar/presentation/screens/curved_navigation_bar.dart';
import 'package:movies_app/features/home/presentation/screens/movie_trailing_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/app_style.dart';
import '../../../favorite/presentation/manger/favorite_movie_provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({required this.movie});

  final MoviesModel movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteMovieProvider = Provider.of<FavoriteMovieProvider>(context);
    final isFavorite =
        favoriteMovieProvider.isFavoriteMovie('${widget.movie.id}');

    return Scaffold(
      body: FutureBuilder<MovieModel>(
        future: HttpServices.getMovieTrailer('${widget.movie.id}'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 450.h,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: widget.movie.image!,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                            child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 28.sp,
                                color: Color(0xffEB5757),
                              ),
                              onPressed: () {
                                navigate(
                                    context: context,
                                    screen: CurvedNavigatonBarScreen());
                              },
                            ),
                            SizedBox(
                              width: 260.sp,
                            ),
                            CustomIconButton(
                              onPressed: () {
                                if (isFavorite) {
                                  favoriteMovieProvider.removeFavoriteMovie(
                                      '${widget.movie.id}');
                                } else {
                                  favoriteMovieProvider.addFavoriteMovie(
                                    '${widget.movie.id}',
                                    '${widget.movie.title}',
                                    '${widget.movie.image}',
                                  );
                                }
                              },
                              icon: isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded,
                            )
                          ],
                        ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${widget.movie.title}',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: AppStyles.style24(context)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                widget.movie.genre!.join(' , '),
                                style: AppStyles.label18(context),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xffEB5757),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description :',
                                style: AppStyles.stylee24(context),
                              ),
                              Text(
                                '${widget.movie.description}',
                                softWrap: true,
                                style: AppStyles.text16(context),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xffEB5757),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.play_circle_outline,
                                color: Color(0xffEB5757),
                                size: 32.sp,
                              ),
                              Text(
                                'Watch trailer',
                                style: AppStyles.stylee24(context),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            height: 200.h,
                            child: Center(
                              child: YoutubePlayerScreen(
                                  videoId:
                                      '${snapshot.data!.trailerYoutubeId}'),
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            print(snapshot.error);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
