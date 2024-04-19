import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteServices {
  static Database? _database ;

  Future<Database?> get database async{
    if(_database == null){
      _database = await init();
      return _database;
    }
    else{
      return _database;
    }
  }


  init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'movies.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
    return database;
  }

  onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE 'favourites' (id TEXT , title TEXT , image TEXT)");
  }

  Future<List<Map>> getData()async{
    Database? myDatabase = await database;
    List<Map<String,dynamic>> response = await myDatabase!.rawQuery("SELECT * FROM 'favourites'");
    return response;

  }

  Future<void> insertData({
    required String id,
    required String title,
    required String image,
  })async{
    Database? myDatabase = await database;
    await myDatabase!.rawInsert("INSERT INTO 'favourites' ('id' ,'title', 'image') VALUES( '$id' , '$title' , '$image')");
  }

  Future<int> deleteData({
    required String id,
  })async{
    Database? myDatabase = await database;
    int bookId = await myDatabase!.rawDelete("DELETE FROM 'favourites' WHERE id = ?", [id]);
    return bookId;
  }
}























// import 'package:movies_app/features/home/data/models/movie_model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// import '../../features/home/data/models/movies_model.dart';
//
// final String movieTitle = 'title';
// final String movieId = 'id';
// final String movieYear = 'year';
// final String movieRating = 'rating';
// final String movieTable = 'movie_table';
// final String movieRank = 'movieRank';
//
// class SqfliteServices {
//   late Database db;
//
//   static final SqfliteServices instance = SqfliteServices._internal();
//
//   factory SqfliteServices() {
//     return instance;
//   }
//
//   SqfliteServices._internal();
//
//
//   Future open() async {
//     try {
//       db = await openDatabase(
//         join(await getDatabasesPath(), 'app.db'),
//         version: 1,
//         onCreate: (Database db, int version) async {
//           await db.execute('''
//         CREATE TABLE $movieTable (
//           $movieTitle TEXT,
//           $movieYear TEXT,
//           $movieRating TEXT,
//           $movieId TEXT,
//           $movieRank INTEGER
//         );
//         ''');
//         },
//       );
//     } catch (e) {
//       print('****************************************************************Error opening database: $e');
//       // Handle the error here, such as showing an error message to the user.
//     }
//   }
//
//
//
//   Future<void> insertMovie(MoviesModel movie) async {
//     var dbClient = await db;
//     await dbClient.transaction((txn) async {
//       await txn.insert(
//         movieTable,
//         movie.toMap(),
//       );
//     });
//   }
//
//
//   Future<List<MoviesModel>> getAllMovies() async {
//     List<Map<String, dynamic>> moviesMaps = await db.query(movieTable);
//     List<MoviesModel> movies = [];
//     for (var element in moviesMaps) {
//       movies.add(MoviesModel.fromJson(element));
//     }
//     return movies;
//   }
//
//   Future<int> deleteMovie(int id) async {
//     return await db.delete(
//       movieTable,
//       where: '$movieId = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future close() async => db.close();
// }
