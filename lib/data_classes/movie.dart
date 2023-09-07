class Movie {
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
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

  Movie({
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

  String get movieReleaseDate =>
      '${releaseDate.day}/${releaseDate.month}/${releaseDate.year}';

  factory Movie.defaultMovie() {
    return Movie(
      title: "The Super Mario Bros. Movie",
      originalTitle: "The Super Mario Bros. Movie",
      overview: "While working underground to fix a "
          "water main, Brooklyn plumbers—and brothers—Mario and Luigi are "
          "transported down a mysterious pipe and wander into a magical new "
          "world. But when the brothers are separated, Mario embarks on an epic "
          "quest to find Luigi.",
      releaseDate: DateTime(
        2023,
        4,
        5,
      ),
      voteAverage: 7.8,
      genres: [
        16,
        10751,
        12,
        14,
        35,
      ],
      poster: 'movie_images/poster.jpg',
      backdrop: 'movie_images/backdrop.jpg',
      originalLanguage: 'en',
      popularity: 3000.3,
      hasVideo: false,
      voteCount: 300,
      isAdult: false,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> movieJson) {
    return Movie(
      title: movieJson["title"],
      originalTitle: movieJson["original_title"],
      overview: movieJson["overview"],
      releaseDate: DateTime.parse(movieJson["release_date"]),
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

  String get posterUrl => imageBaseUrl + poster;

  String get backdropUrl => imageBaseUrl + backdrop;
}
