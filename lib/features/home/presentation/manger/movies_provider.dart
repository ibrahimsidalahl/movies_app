import 'package:flutter/cupertino.dart';
import 'package:movies_app/core/http_services/http_services.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';

class MoviesProvider extends ChangeNotifier{
  List<MoviesModel>? _movies ;
  List<MoviesModel>? get movies => _movies ;

  void set movies (List<MoviesModel>? value){
    _movies = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    movies = await HttpServices.getMovies();
    print(movies);


}
}