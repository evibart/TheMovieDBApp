import '../../domain/entity/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required int id,
    required String title,
    required String originalTitle,
    required String overview,
    required String releaseDate,
    required double voteAverage,
    required List<int> genres,
    required String poster,
    required String backdrop,
    required String originalLanguage,
    required double popularity,
    required bool hasVideo,
    required int voteCount,
    required bool isAdult,
  }) : super(
          id: id,
          title: title,
          originalTitle: originalTitle,
          overview: overview,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          genres: genres,
          poster: poster,
          backdrop: backdrop,
          originalLanguage: originalLanguage,
          popularity: popularity,
          hasVideo: hasVideo,
          voteCount: voteCount,
          isAdult: isAdult,
          categories: [],
        );

  factory MovieModel.fromJson(Map<String, dynamic> movieJson) {
    return MovieModel(
      id: movieJson["id"],
      title: movieJson["title"],
      originalTitle: movieJson["original_title"],
      overview: movieJson["overview"],
      releaseDate: movieJson["release_date"],
      voteAverage: movieJson["vote_average"].toDouble(),
      genres: movieJson["genre_ids"].cast<int>(),
      poster: movieJson["poster_path"],
      backdrop: movieJson["backdrop_path"],
      originalLanguage: movieJson["original_language"],
      popularity: movieJson["popularity"],
      hasVideo: movieJson["video"],
      voteCount: movieJson["vote_count"],
      isAdult: movieJson["adult"],
    );
  }
}
