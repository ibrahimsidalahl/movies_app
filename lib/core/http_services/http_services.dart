import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/features/home/data/models/movies_model.dart';

import '../../features/home/data/models/movie_model.dart';

class HttpServices {
  static final String baseUrl = 'https://imdb-top-100-movies.p.rapidapi.com/';

  static Future<List<MoviesModel>> getMovies() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'X-RapidAPI-Key': '20510b85abmsh1e95b3dc6c14187p1861b1jsn894da5f5ca23',
        'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com'

      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<MoviesModel> movies = jsonData.map((item) => MoviesModel.fromJson(item)).toList();
      return movies;
    } else {
      //print(response.body);
      throw Exception('Failed to load top 100 movies${response.body}');
    }
  }

  static Future<MovieModel> getMovieTrailer(String id) async {
    final String url = 'https://imdb-top-100-movies.p.rapidapi.com/$id';

    final response = await http.get(
      Uri.parse('$url'),
      headers: {
        'X-RapidAPI-Key': '20510b85abmsh1e95b3dc6c14187p1861b1jsn894da5f5ca23',
        'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final MovieModel movie = MovieModel.fromJson(jsonData);
      return movie;
    } else {
      throw Exception('Failed to load top 100 movies ${response.body}');
    }
  }


}
