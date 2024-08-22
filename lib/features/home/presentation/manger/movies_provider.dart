import 'package:flutter/cupertino.dart';
import 'package:movies_app/core/http_services/http_services.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';

class MoviesProvider extends ChangeNotifier {
  List<MoviesModel>? _movies;

  List<MoviesModel>? get movies => _movies;

  void set movies(List<MoviesModel>? value) {
    _movies = value;
    notifyListeners();
  }

  bool _isFetching = false; // للتحقق إذا كان الطلب يتم تنفيذه بالفعل

  Future<List<MoviesModel>?> fetchData() async {
    if (_movies == null && !_isFetching) {
      _isFetching = true; // قم بتعيين الفلاج إلى true لمنع طلبات مكررة
      _movies = await HttpServices.getMovies();
      _isFetching = false; // بعد انتهاء الطلب بنجاح أو بالفشل، أعد الفلاج إلى false
      notifyListeners();
      return movies;
    }
  }
}
