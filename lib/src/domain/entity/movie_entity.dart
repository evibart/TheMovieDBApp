import 'package:flutter/foundation.dart';

import '../../data/model/movie_model.dart';

class MovieEntity {
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final DateTime releaseDate;
  final double voteAverage;
  final List<int> genres;
  final String poster;
  final String backdrop;
  final String originalLanguage;
  final double popularity;
  final bool hasVideo;
  final int voteCount;
  final bool isAdult;

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
      );

  String get movieReleaseDate =>
      '${releaseDate.day}/${releaseDate.month}/${releaseDate.year}';

  String get posterUrl => '$imageBaseUrl$poster';

  String get backdropUrl => '$imageBaseUrl$backdrop';

  @override
  bool operator ==(Object other) =>
      other is MovieEntity &&
      id == other.id &&
      title == other.title &&
      originalTitle == other.originalTitle &&
      overview == other.overview &&
      releaseDate == other.releaseDate &&
      voteAverage == other.voteAverage &&
      listEquals(genres, other.genres) &&
      poster == other.poster &&
      backdrop == other.backdrop &&
      originalLanguage == other.originalLanguage &&
      popularity == other.popularity &&
      hasVideo == other.hasVideo &&
      voteCount == other.voteCount &&
      isAdult == other.isAdult;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      originalTitle.hashCode ^
      overview.hashCode ^
      releaseDate.hashCode ^
      voteAverage.hashCode ^
      genres.hashCode ^
      poster.hashCode ^
      backdrop.hashCode ^
      originalLanguage.hashCode ^
      popularity.hashCode ^
      hasVideo.hashCode ^
      voteCount.hashCode ^
      isAdult.hashCode;
}
