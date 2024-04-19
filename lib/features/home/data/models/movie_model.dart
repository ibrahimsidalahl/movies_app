class MovieModel{

  late String trailerYoutubeId;
  MovieModel({
    required this.trailerYoutubeId,
});
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      trailerYoutubeId:  json['trailer_youtube_id'],

    );
  }


  Map<String, dynamic> toMap() {
    return {
      'trailer_youtube_id':trailerYoutubeId,
    };
  }
}