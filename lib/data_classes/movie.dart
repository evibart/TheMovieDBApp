class Movie {
  final String title;
  final String originalTitle;
  final String overview;
  final DateTime releaseDate;
  final double voteAverage;
  final List<String> genres;
  final String poster;
  final String backdrop;

  Movie(
    this.title,
    this.originalTitle,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.genres,
    this.poster,
    this.backdrop,
  );

  String get movieReleaseDate =>
      '${releaseDate.day}/${releaseDate.month}/${releaseDate.year}';

  factory Movie.defaultMovie() {
    return Movie(
      "The Super Mario Bros. Movie",
      "The Super Mario Bros. Movie",
      "While working underground to fix a "
          "water main, Brooklyn plumbers—and brothers—Mario and Luigi are "
          "transported down a mysterious pipe and wander into a magical new "
          "world. But when the brothers are separated, Mario embarks on an epic "
          "quest to find Luigi.",
      DateTime(
        2023,
        4,
        5,
      ),
      7.8,
      ["Animation", "Family", "Adventure", "Fantasy", "Comedy"],
      'movie_images/poster.jpg',
      'movie_images/backdrop.jpg',
    );
  }
}
