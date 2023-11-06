import 'package:floor/floor.dart';
import 'package:json_class/json_class.dart';

import '../../data/datasource/local/converter/int_converter.dart';
import '../../data/model/movie_model.dart';

@entity
class MovieEntity extends JsonClass {
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  @primaryKey
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  @TypeConverters([IntListConverter])
  final List<int> genres;
  final String poster;
  final String backdrop;
  final String originalLanguage;
  final double popularity;
  final bool hasVideo;
  final int voteCount;
  final bool isAdult;
  List<String> categories;


  MovieEntity({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.genres,
    required this.poster,
    required this.backdrop,
    required this.originalLanguage,
    required this.popularity,
    required this.hasVideo,
    required this.voteCount,
    required this.isAdult,
    required this.categories,
  });

  factory MovieEntity.fromMovieModel({required MovieModel movieModel}) =>
      MovieEntity(
        id: movieModel.id,
        title: movieModel.title,
        originalTitle: movieModel.originalTitle,
        overview: movieModel.overview,
        releaseDate: movieModel.releaseDate,
        voteAverage: movieModel.voteAverage,
        genres: movieModel.genres,
        poster: movieModel.poster,
        backdrop: movieModel.backdrop,
        originalLanguage: movieModel.originalLanguage,
        popularity: movieModel.popularity,
        hasVideo: movieModel.hasVideo,
        voteCount: movieModel.voteCount,
        isAdult: movieModel.isAdult,
        categories: [],
      );

  String get posterUrl => '$imageBaseUrl$poster';

  String get backdropUrl => '$imageBaseUrl$backdrop';

  @override
  bool operator ==(Object other) =>
      other is MovieEntity &&
          id == other.id;


  @override
  int get hashCode => id.hashCode;

  @override
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'original_title': originalTitle,
        'overview': overview,
        'release_date': releaseDate,
        'vote_average': voteAverage,
        'genre_ids': genres,
        'poster_path': poster,
        'backdrop_path': backdrop,
        'original_language': originalLanguage,
        'popularity': popularity,
        'video': hasVideo,
        'vote_count': voteCount,
        'adult': isAdult,
      };
}
