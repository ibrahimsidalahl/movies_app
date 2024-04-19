class MoviesModel {
  late int? rank;
  late String? title;
  late String? description;
  late String? image;
  late List<dynamic>? genre;
  late String? rating;
  late String? id;
  late int? year;


  MoviesModel(
      {
        this.rank,
         this.title,
         this.description,
        this.image,
        this.genre,
         this.rating,
         this.id,
         this.year,
       });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      rank: json['rank'],

      title: json['title'],
      description: json['description'],
      image: json['image'],
      genre: json['genre'],
      rating: json['rating'],
      id: json['id'],
      year: json['year'],

    );

  }


  Map<String, dynamic> toMap() {
    return {
      'rank': rank,
      'title': title,
      'description': description,
      'image': image,
      'genre': genre,
      'rating': rating,
      'id': id,
      'year': year,

    };
  }
}
